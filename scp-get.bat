:: SCP-Get (scp-get):
::     Uses WinSCP to allow you to use a directory on a file server as a private software repository.
:: Author(s):
::     Penafiel, John Lawrence M. (penafieljlm)
:: Usage:
::     scp-get install INTALLER_NAME

:: Initialize
@echo off
set _PROTOCOL=sftp
set _SERV=
set _PATH=
set _USER=
set _PASS=

:: Check Server
if not "%_SERV%"=="" (
	goto :skip_serv
)
set /P USER=Server: 
:skip_serv

:: Check Path
if not "%_PATH%"=="" (
	goto :skip_path
)
set /P PATH=Path to scp-get on Server: 
:skip_path

:: Check Username
if not "%_USER%"=="" (
	goto :skip_user
)
set /P USER=Username: 
:skip_user

:: Check Password
if not "%_PASS%"=="" (
	goto :skip_pass
)
powershell -Command $pword = read-host "Password" -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt & set /p PASS=<.tmp.txt & del .tmp.txt
:skip_pass

:: Check command parameters
if "%1"=="install" (
	goto :do_install
)
echo Error: Unknown command %1
pause
goto :eof

:do_install
:: Get File Name
if "%2"=="" (
	echo Error: You need to specify a file name for "install"
	pause
	goto :eof
)
:: Create SFTP Script
del .sftp>nul 2>&1
echo open %_PROTOCOL%://%_USER%:%_PASS%@%_SERV%/ >> .sftp
echo cd "%_PATH%/install" >> .sftp
echo option transfer binary >> .sftp
echo get "%2.bat" >> .sftp
echo close >> .sftp
echo exit >> .sftp
:: Run SFTP Script
if exist "C:\Program Files (x86)\WinSCP\WinSCP.com" (
	"C:\Program Files (x86)\WinSCP\WinSCP.com" /script=.sftp
	goto :do_execute
)
if exist "C:\Program Files\WinSCP\WinSCP.com" (
	"C:\Program Files\WinSCP\WinSCP.com" /script=.sftp
	goto :do_execute
)
del .sftp>nul 2>&1
echo Error: Unable to find WinSCP
pause
goto :eof

:do_execute
del .sftp>nul 2>&1
:: Execute Downloaded Batch Script
"%2.bat"
pause
goto :eof