#Requires AutoHotkey v2.0
#SingleInstance Force
#include constants.ahk

if (A_IsCompiled && InstallationIsRequired()) {
    PerformInstallation()
}

RunWaitCustom(Constants.SCRIPT_COMPILER)

RunWaitCustom(Constants.SCRIPT_REBINDS)

RemoveTemporaryConfigurationFile()
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

