#Requires AutoHotkey v2.0
#SingleInstance Force

;#Include Rebinds.config

TEMPORARY_CONFIGURATION_FILE_PATH := "rebinds-compiled.tmp"

try {
    configurationFile := FileOpen('rebinds.config', "r")
}
catch as Err {
    MsgBox "rebinds.config file is missing :( `n`n" Type(Err) ": " Err.Message
    return
}

; Generate script from config
    ; For each line
        ; (\S+\s*(->)+\s*\S+) regex for validation
        ;  regex for replacement with ::
        ; Add modded line to str
    ; Create file
        ; Create the file
        ; Add input
        ; Close file handle
    ; #Include file
    ; Delete file

    ;This should be required to work correctly: FileInstall


configurationCode := ""
lineCounter := 0
while (configurationFile.AtEOF == false) {
    line := configurationFile.ReadLine()
    lineCounter++
    if (!LineIsValid(line)) {
        continue
    }

    modifiedLine := ModifyLine(line)
    if (modifiedLine == line) {
        MsgBox("Line " lineCounter " was not a valid input for some inexplicable reason.")
        continue    
    }
    configurationCode := configurationCode "`n" modifiedLine
}

CreateTemporaryConfigurationFile("; This file was generated automatically and should not be edited!`n" configurationCode)
;#Include rebinds-compiled.tmp ; TODO: fix this to use const
RemoveTemporaryConfigurationFile()



LineIsValid(line) {
    return (RegExMatch(line, "(\S+\s*(->)+\s*\S+)") != 0) ? true : false
}

ModifyLine(line) {
    return RegExReplace(line, "(\s*(->)+\s*)", "::", &replacementCount, )
}

CreateTemporaryConfigurationFile(fileContents) {
    RemoveTemporaryConfigurationFile()
    try {
        FileAppend(fileContents, TEMPORARY_CONFIGURATION_FILE_PATH)
    }
    catch as Err {
        MsgBox("An error occured when creating temporary file! `n`n" Type(Err) ": " Err.Message)
    }
}

RemoveTemporaryConfigurationFile() {
    if (FileExist(TEMPORARY_CONFIGURATION_FILE_PATH)) {
        FileDelete(TEMPORARY_CONFIGURATION_FILE_PATH)
    }
}




;c::i
;Numpad0::k