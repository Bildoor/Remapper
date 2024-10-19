@Echo off
Echo Removing all files in dist directory
cd dist
for %%p in (*) do del %%p
cd ../
Echo Directory is now clean
Echo Compiling program...
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in ./remapper.ahk /out ./dist/remapper.exe /icon ./assets/remapper.ico /base "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
Echo Program compiled successfully!
PAUSE