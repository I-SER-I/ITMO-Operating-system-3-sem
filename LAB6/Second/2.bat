forfiles /P "C:\Windows" /C "cmd /c if @fsize GEQ 2097152 copy @path %~dp0temp /Z"
