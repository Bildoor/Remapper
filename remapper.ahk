#Requires AutoHotkey v2.0
#SingleInstance Force
#include constants.ahk

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
