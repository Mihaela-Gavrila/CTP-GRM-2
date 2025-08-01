@echo off
echo ========================================
echo    GRM 2.0 - GENERATOR AUTOMAT  
echo ========================================
echo.
echo Creez toate folderele...
mkdir backend\src\main\java\ro\ctp\grm\entity 2>nul
mkdir backend\src\main\java\ro\ctp\grm\repository 2>nul  
mkdir backend\src\main\java\ro\ctp\grm\service 2>nul
mkdir backend\src\main\java\ro\ctp\grm\controller 2>nul
mkdir backend\src\main\java\ro\ctp\grm\config 2>nul
mkdir backend\src\main\java\ro\ctp\grm\security 2>nul
mkdir backend\src\main\java\ro\ctp\grm\dto 2>nul
mkdir backend\src\main\java\ro\ctp\grm\exception 2>nul
mkdir backend\src\main\resources\db\migration 2>nul
mkdir frontend\src\components 2>nul
mkdir frontend\src\pages 2>nul
mkdir frontend\src\services 2>nul
mkdir frontend\src\store 2>nul
mkdir frontend\public 2>nul
mkdir .github\workflows 2>nul
echo û Toate folderele create!
echo.
echo Creez fisierele principale...
pause
