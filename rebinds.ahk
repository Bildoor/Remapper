﻿#Requires AutoHotkey v2.0
#SingleInstance Force
#Include constants.ahk
#NoTrayIcon

#Include rebinds-compiled.tmp ; TODO: fix this to use const

; Close application with help of Ctrl + Shift + S
^+s::{
    MsgBox("Exiting`n`nThank you for running Remapper!", "Exiting")
    ExitApp
}

