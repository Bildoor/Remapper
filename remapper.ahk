#Requires AutoHotkey v2.0
#SingleInstance Force
#include constants.ahk
#include configuration.ahk

MyGui := Gui()
config := Configuration()

if (A_IsCompiled && InstallationIsRequired()) {
    PerformInstallation()
}

ReadCommandLineArguments(&config)

if (config.showProgramLogo) {
    DrawGui(&MyGui)
}

RunWaitCustom(Constants.SCRIPT_COMPILER)

RunWaitCustom(Constants.SCRIPT_REBINDS)

RemoveTemporaryConfigurationFile()
MyGui.Destroy()
ExitApp

InstallationIsRequired() {
    for(filename in ["constants.ahk", "compiler.ahk", "rebinds.ahk", "rebinds.config"]) {
        if(!FileExist(filename)) {
            return true
        }
    }

    return false
}

PerformInstallation() {
    FileInstall("assets/AutoHotkey64.exe", "AutoHotkey64.exe", true)
    FileInstall("constants.ahk", "constants.ahk", true)
    FileInstall("compiler.ahk", "compiler.ahk", true)
    FileInstall("rebinds.ahk", "rebinds.ahk", true)
    FileInstall("assets/remapper.png", "remapper.png", true)
    FileInstall("rebinds.config", "rebinds.config", false)
}

RemoveTemporaryConfigurationFile() {
    if (FileExist(Constants.TEMP_CONFIG_FILE_PATH)) {
        FileDelete(Constants.TEMP_CONFIG_FILE_PATH)
    }
}

RunWaitCustom(filename) {
    if(A_IsCompiled) {
        RunWait("AutoHotkey64.exe " filename)
        return
    }
    RunWait(filename)
}

DrawGui(&gui) {
    gui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
    gui.BackColor := "CCCCCC"  ; Can be any RGB color (it will be made transparent below).
    gui.AddPicture("w50 h-1", (A_IsCompiled) ? "remapper.png" : "assets/remapper.png")

    ; Make all pixels of this color transparent and make the text itself translucent (150):
    WinSetTransColor(gui.BackColor " 200", MyGui)
    bottomPixel := -1
    rightPixel := -1
    monitorInfo := MonitorGetWorkArea(MonitorGetPrimary(), , ,&rightPixel, &bottomPixel)
    gui.Show("x" rightPixel-90 " y" bottomPixel - 75 " NoActivate")  ; NoActivate avoids deactivating the currently active window.
}

ReadCommandLineArguments(&configuration) {
    for(argument in A_Args) {
        MsgBox(argument)
        if(RegExMatch(argument, "nologo")) {
            configuration.showProgramLogo := false
        }
    }
}

