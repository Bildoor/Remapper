::Remove all files in dist directory first
cd dist
for %%p in (*) do del %%p
cd ../
::Compile program
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ./remapper.ahk /out ./dist/remapper.exe /icon ./assets/remapper.ico /base "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"