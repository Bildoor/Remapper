# Remapper
## _A simple keyboard remapper written in AutoHotkey_

### Usage notes
To use this software, download the latest release from [github](https://github.com/Bildoor/Remapper/releases) and put the executable in a directory of your liking. *note: the program will add a few additional files, so it is recommended to put this program in its own dedicated directory*
When program is run for the first time the default configuration is loaded. To change this you should start with exiting the program using Ctrl + Shift + S and editing the generated "rebinds.config" file.

This file follows this syntax
    targetbutton -> desiredbutton
so if you wanted to rebind your c key to output i, you would enter
    c -> i
multiple bindings can be added line by line, so if you wanted to swap c and i you would do the following
    c -> i
    i -> c
When trying to bind other keys than letters you might need to follow [this}(https://www.autohotkey.com/docs/v2/KeyList.htm) reference to see what keys are called in AHK, since that is the backbone of this whole project.


