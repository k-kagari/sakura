@echo off
set LOGFILE=%1

if "%LOGFILE%" == "" (
	call :showhelp %0
	exit /b 1
)

if not exist "%LOGFILE%" (
	@echo.
	@echo "%LOGFILE%" does not exist.
	@echo.
	call :showhelp %0
	exit /b 1
)

set ERROR_RESULT=0
if not defined CMD_PYTHON call %~dp0tools\find-tools.bat
if not defined CMD_PYTHON (
	@echo NOTE: No python command
) else (
	%CMD_PYTHON% appveyor_env.py
	%CMD_PYTHON% parse-buildlog.py %LOGFILE% || set ERROR_RESULT=1
)
exit /b %ERROR_RESULT%

@rem ------------------------------------------------------------------------------
@rem show help
@rem see http://orangeclover.hatenablog.com/entry/20101004/1286120668
@rem ------------------------------------------------------------------------------
:showhelp
@echo off
@echo usage
@echo    %~nx1 "log file"
@echo.
@echo parameter
@echo    log file : log file name to be parsed
@echo.
@echo example
@echo    %~nx1 msbuild-Win32-Release.log
exit /b 0
