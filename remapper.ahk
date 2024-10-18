#Requires AutoHotkey v2.0
#SingleInstance Force
#include constants.ahk
FileInstall("constants.ahk", "constants.ahk")
FileInstall("compiler.ahk", "compiler.ahk")
FileInstall("rebinds.ahk", "rebinds.ahk")
;This should be required to work correctly: FileInstall

MsgBox("File is here: " Constants.SCRIPT_COMPILER)

if (!CompiledFileExists()) {
    RunWait Constants.SCRIPT_COMPILER
}

RunWait Constants.SCRIPT_REBINDS

RemoveTemporaryConfigurationFile()
ExitApp


RemoveTemporaryConfigurationFile() {
    if (FileExist(Constants.TEMP_CONFIG_FILE_PATH)) {
        FileDelete(Constants.TEMP_CONFIG_FILE_PATH)
    }
}

CompiledFileExists() {
    return false
}
