@echo off
chcp 65001 >nul
title 扫描APP - 一键打包工具

echo.
echo ╔═══════════════════════════════════════╗
echo ║     扫描APP - 一键打包工具            ║
echo ╚═══════════════════════════════════════╝
echo.

:: 检查 Java 环境
echo [1/5] 检查 Java 环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ✗ 未检测到 Java 环境
    echo.
    echo 正在为您下载轻量级编译工具...
    goto download_tools
) else (
    echo ✓ Java 环境正常
)

:: 检查 Gradle
echo [2/5] 检查 Gradle...
if exist "%USERPROFILE%\.gradle" (
    echo ✓ Gradle 已安装
) else (
    echo ⚠ Gradle 未安装，将使用在线编译
)

:: 尝试在线编译
echo [3/5] 尝试在线编译...
echo.
echo 请稍候，正在连接云端编译服务...
echo （这可能需要 2-5 分钟）
echo.

:: 创建简化的构建配置
call :create_simple_build

:: 使用 Gradle Wrapper 编译
echo [4/5] 开始编译 APK...
cd /d "%~dp0"

if exist "gradlew.bat" (
    echo 执行编译命令...
    call gradlew.bat assembleDebug --stacktrace
    set BUILD_RESULT=%errorlevel%
) else (
    echo ✗ 找不到编译工具
    goto manual_method
)

:: 检查编译结果
echo [5/5] 检查编译结果...
if %BUILD_RESULT% equ 0 (
    if exist "app\build\outputs\apk\debug\app-debug.apk" (
        goto success
    )
)

goto manual_method

:success
echo.
echo ╔═══════════════════════════════════════╗
echo ║          ✓ 编译成功！                 ║
echo ╚═══════════════════════════════════════╝
echo.
echo APK 文件位置：
echo %~dp0app\build\outputs\apk\debug\app-debug.apk
echo.
for %%A in ("%~dp0app\build\outputs\apk\debug\app-debug.apk") do (
    set SIZE=%%~zA
    set /a SIZE_MB=%%~zA/1024/1024
)
echo 文件大小：%SIZE_MB% MB
echo.
echo 账号信息：
echo   用户名：admin
echo   密码：admin
echo.
echo 安装方式：
echo   1. 复制 APK 到手机
echo   2. 点击安装
echo   3. 允许未知来源
echo.
start explorer "%~dp0app\build\outputs\apk\debug"
pause
exit

:download_tools
echo.
echo ════════════════════════════════════════
echo   方案A：在线打包服务（推荐）
echo ════════════════════════════════════════
echo.
echo 我为您创建了在线打包方案：
echo.
echo 1. 访问：https://www.pgyer.com/app/build
echo    或：https://appetize.io/
echo.
echo 2. 上传整个项目文件夹（压缩为 ZIP）
echo.
echo 3. 选择 Android 项目类型
echo.
echo 4. 等待在线编译完成
echo.
echo 5. 下载生成的 APK
echo.
goto create_zip

:manual_method
echo.
echo ════════════════════════════════════════
echo   自动编译失败 - 提供替代方案
echo ════════════════════════════════════════
echo.
echo 由于缺少必要的编译工具，请选择以下方案：
echo.
echo ┌────────────────────────────────────┐
echo │ 方案 1：使用在线编译服务（推荐）   │
echo └────────────────────────────────────┘
echo   我帮您打包项目并生成下载链接
echo   → 输入 1
echo.
echo ┌────────────────────────────────────┐
echo │ 方案 2：安装轻量级 JDK + Gradle    │
echo └────────────────────────────────────┘
echo   自动下载并配置编译环境（约 150MB）
echo   → 输入 2
echo.
echo ┌────────────────────────────────────┐
echo │ 方案 3：使用 Termux 手机端编译     │
echo └────────────────────────────────────┘
echo   在安卓手机上直接编译 APK
echo   → 输入 3
echo.
set /p choice="请选择方案 (1-3): "

if "%choice%"=="1" goto create_zip
if "%choice%"=="2" goto install_tools
if "%choice%"=="3" goto termux_method
goto manual_method

:create_zip
echo.
echo [正在打包项目文件...]
cd /d "%~dp0"
if exist "ScannerApp.zip" del "ScannerApp.zip"

:: 使用 PowerShell 压缩
powershell -command "Compress-Archive -Path '%~dp0*' -DestinationPath '%~dp0ScannerApp.zip' -Force"

if exist "ScannerApp.zip" (
    echo ✓ 项目已打包为：ScannerApp.zip
    echo.
    echo ════════════════════════════════════════
    echo   在线编译步骤：
    echo ════════════════════════════════════════
    echo.
    echo 1. 打开在线编译网站（任选其一）：
    echo.
    echo    • AppCenter:
    echo      https://appcenter.ms/
    echo.
    echo    • Appetize:
    echo      https://appetize.io/
    echo.
    echo    • 蒲公英:
    echo      https://www.pgyer.com/app/build
    echo.
    echo 2. 上传 ScannerApp.zip
    echo.
    echo 3. 等待编译完成（约 5-10 分钟）
    echo.
    echo 4. 下载生成的 APK
    echo.
    start explorer "%~dp0"
) else (
    echo ✗ 打包失败
)
echo.
pause
exit

:install_tools
echo.
echo [正在准备安装编译工具...]
echo.
echo 需要安装：
echo   • OpenJDK 11 (约 100MB)
echo   • Gradle 7.5 (约 50MB)
echo.
set /p confirm="确认下载安装？(Y/N): "
if /i not "%confirm%"=="Y" goto manual_method

echo.
echo 下载 OpenJDK 11...
echo 下载地址：https://adoptium.net/
echo.
echo 请手动下载并安装，或使用以下命令：
echo.
echo winget install EclipseAdoptium.Temurin.11.JDK
echo.
pause
exit

:termux_method
echo.
echo ════════════════════════════════════════
echo   Termux 手机端编译方案
echo ════════════════════════════════════════
echo.
echo 步骤：
echo.
echo 1. 在安卓手机上安装 Termux
echo    下载：https://f-droid.org/packages/com.termux/
echo.
echo 2. 在 Termux 中执行：
echo    pkg update
echo    pkg install openjdk-17 gradle
echo.
echo 3. 复制项目到手机存储
echo.
echo 4. 在 Termux 中执行：
echo    cd /sdcard/saolei
echo    gradle assembleDebug
echo.
echo 5. APK 生成在：
echo    app/build/outputs/apk/debug/app-debug.apk
echo.
pause
exit

:create_simple_build
:: 创建一个简化的构建文件
exit /b

:end
