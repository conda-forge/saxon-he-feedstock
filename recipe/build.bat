@echo off

set "INSTALL_DIR"=%LIBRARY_PREFIX%\lib\SaxonHE"

:: Install built files
mkdir %INSTALL_DIR%
xcopy saxon-he-*.jar %INSTALL_DIR% /s /i /y
if errorlevel 1 exit 1

mkdir %INSTALL_DIR%\lib
xcopy lib\* %INSTALL_DIR%\lib /s /i /y
if errorlevel 1 exit 1

mkdir %INSTALL_DIR%\doc
xcopy doc\* %INSTALL_DIR%\doc /s /i /y
if errorlevel 1 exit 1

mkdir %INSTALL_DIR%\notices
xcopy notices\* %INSTALL_DIR%\notices /s /i /y
if errorlevel 1 exit 1

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
for %%F in (activate deactivate) do (
    if not exist %PREFIX%\etc\conda\%%F.d mkdir %PREFIX%\etc\conda\%%F.d
    if errorlevel 1 exit 1
    copy %RECIPE_DIR%\scripts\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)