#Requires AutoHotkey v2.0
#SingleInstance Force
#include constants.ahk

if (InstallationIsRequired()) {
    PerformInstallation()
}

if (!CompiledFileExists()) {
    RunWait Constants.SCRIPT_COMPILER
}

RunWait Constants.SCRIPT_REBINDS

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

CompiledFileExists() {
    return false
}
