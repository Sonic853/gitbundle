@REM git clone <url>
@REM cd <filename>
@REM git bundle create ../<filename>.git.bundle --all
@REM cd ..
@REM rmdir /s /q <filename>

@REM gitbundle url [filename]

@echo off

@REM 判断 %1 是否为空
setlocal

set url=%~1
set filename=%~2

if not "%url%"=="" (
    goto startcheck
)

@REM 提示输入
echo Please input git url:
set /p url=

if "%url%"=="" (
    goto usage
)

echo Please input bundle filename, press enter to use default filename:
set /p filename=


:startcheck
@REM 判断 %1 是否为url
@REM https://github.com/Sonic853/UdonLabToolkit
@REM https://github.com/Sonic853/UdonLabToolkit.git
@REM git@github.com:Sonic853/UdonLabToolkit.git
@REM ssh://git@github.com/Sonic853/UdonLabToolkit.git

@REM if "%1"=="%1:http*" (
if "%url:~0,4%"=="http" (
    goto checkend
) else if "%url:~0,4%"=="git@" (
    goto checkend
) else if "%url:~0,4%"=="ssh:" (
    goto checkend
) else (
    goto bundleonly
)

:checkend
@REM 判断 %url% 是否以 .git 结尾，如果不是，则添加 .git
if "%url:~-4%"==".git" (
    goto checkfilename
) else (
    set url=%url%.git
)


:checkfilename
@REM 判断 %2 是否为空，如果为空，则使用url的最后一段作为文件名

if "%~2"=="" (
    if "%filename%"=="" (
        goto setfilenamewithbundle
    )
) else (
    goto setfilename
)


:setfilenamewithbundle
for /f "tokens=*" %%i in ("%url%") do set filename=%%~ni
set foldername=%filename%.gitbundlecache
set filename=%filename%.git.bundle
goto checkfileandfolder
:setfilename
set filename=%~2
for /f "tokens=*" %%i in ("%url%") do set foldername=%%~ni.gitbundlecache
goto checkfileandfolder

:checkfileandfolder
@REM 判断 %filename% 是否存在，如果存在，则报错
if exist %foldername% (
    echo %foldername% already exists.
    goto end
)

@REM 判断 %filename%.git.bundle 是否存在，如果存在，则报错
if exist %filename% (
    echo %filename% already exists.
    goto end
)

git clone %url% %foldername%
cd %foldername%
echo.
echo Start create bundle...
git bundle create ../%filename% --all
cd ..
@REM 判断 %filename%.git.bundlecache 是否被占用，如果被占用，则等待 1 秒再删除
:checkfile
rmdir /s /q %foldername%
if exist %foldername% (
    timeout /t 1
    goto checkfile
)
goto endps

:bundleonly
@REM 未检查 %filename% 是否为空，如果为空，则使用url的最后一段作为文件名
@REM 记录当前路径
set currentpath=%cd%
@REM 判断 %url% 是否是本地路径
if not exist %url% (
    goto usage
)
if "%filename%"=="" (
    goto bundleonlysetfilename
) else (
    goto bundleonlycheckfilename
)
:bundleonlysetfilename
for /f "tokens=*" %%i in ("%url%") do set filename=%%~ni.git.bundle
goto bundleonlycheckfilename
:bundleonlycheckfilename
if exist %currentpath%\%filename% (
    echo %filename% already exists.
    goto end
)
cd "%url%"
git bundle create %currentpath%\%filename% --all
cd %currentpath%
goto endps


:endps
echo.
echo %filename% created. use command:
echo.
echo git clone %filename%
echo.
echo to clone the repository.
goto end


:usage
echo.
echo usage:
echo gitbundle url [filename]
echo.
echo url: git url or local git folder
echo filename: bundle filename
echo.
echo example:
echo gitbundle https://github.com/Sonic853/UdonLabToolkit
echo gitbundle https://github.com/Sonic853/UdonLabToolkit.git UdonLabToolkit.git.bundle
echo gitbundle D:\Git\UdonLabToolkit
echo gitbundle D:\Git\UdonLabToolkit UdonLabToolkit.bundle
echo gitbundle AGitFolder AGitFile.git.bundle
echo.
pause

:end

endlocal
