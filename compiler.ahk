; This program assumes that the compiler needs to run and therefore runs no matter if it is needed or not.

#Include constants.ahk

configurationFile := ""
if (!OpenConfigurationFile(&configurationFile)) {
    MsgBox "rebinds.config file is missing :("
}

compiledScript := ConfigurationFileToCodeString(configurationFile)

CreateTemporaryConfigurationFile(
    "; -->VersionNr<--`n" 
    "; This file was generated automatically and should not be edited!`n" 
    compiledScript
    "`n MsgBox('If you see this then compiler is run!')"
)

Exit


OpenConfigurationFile(&configurationFile) {
    try {
        configurationFile := FileOpen('rebinds.config', "r")
    }
    catch {
        return false
    }
    return true
}

ConfigurationFileToCodeString(configurationFile) {
    configurationCode := ""
    lineCounter := 0
    while (configurationFile.AtEOF == false) {
        line := configurationFile.ReadLine()
        lineCounter++
        if (!ConfigurationLineIsValid(line)) {
            MsgBox("Line " lineCounter " contained: '" line "'which is not a valid configuration.")
            continue
        }
    
        modifiedLine := ModifyConfigurationLine(line)
        if (modifiedLine == line) {
            MsgBox("Line " lineCounter " was not a valid input for some inexplicable reason.")
            continue    
        }
        configurationCode := configurationCode "`n" modifiedLine
    }
    return configurationCode
}

ConfigurationLineIsValid(line) {
    return (RegExMatch(line, "(\S+\s*(->)+\s*\S+)") != 0) ? true : false
}

ModifyConfigurationLine(line) {
    return RegExReplace(line, "(\s*(->)+\s*)", "::", &replacementCount, )
}

CreateTemporaryConfigurationFile(fileContents) {
    RemoveTemporaryConfigurationFile()
    try {
        FileAppend(fileContents, Constants.TEMP_CONFIG_FILE_PATH)
    }
    catch as Err {
        MsgBox("An error occured when creating temporary file! `n`n" Type(Err) ": " Err.Message)
    }
}

RemoveTemporaryConfigurationFile() {
    if (FileExist(Constants.TEMP_CONFIG_FILE_PATH)) {
        FileDelete(Constants.TEMP_CONFIG_FILE_PATH)
    }
}