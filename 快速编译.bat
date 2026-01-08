@echo off
chcp 65001 >nul
title 扫描APP - 快速编译工具

echo.
echo ════════════════════════════════════════
echo     扫描APP - 快速编译工具
echo ════════════════════════════════════════
echo.
echo 正在为您准备编译方案...
echo.

:: 检查 Java 环境
java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ 检测到 Java 环境
    goto try_build
) else (
    echo ✗ 未检测到 Java 环境
    goto online_method
)

:try_build
echo.
echo [方案 1] 尝试本地编译...
echo.
cd /d "%~dp0"

if exist "gradlew.bat" (
    echo 正在编译，请稍候...
    echo （首次编译需要下载依赖，可能需要5-10分钟）
    echo.
    call gradlew.bat assembleDebug
    
    if exist "app\build\outputs\apk\debug\app-debug.apk" (
        goto success
    )
)

:online_method
echo.
echo ════════════════════════════════════════
echo   推荐方案：GitHub 自动编译
echo ════════════════════════════════════════
echo.
echo 由于本地环境不完整，建议使用 GitHub 在线编译
echo.
echo 我已经为您准备好所有文件，只需3步：
echo.
echo ┌────────────────────────────────────┐
echo │ 步骤 1：创建 GitHub 账号           │
echo └────────────────────────────────────┘
echo   访问：https://github.com
echo   如果已有账号，直接登录
echo.
echo ┌────────────────────────────────────┐
echo │ 步骤 2：创建仓库并上传文件         │
echo └────────────────────────────────────┘
echo   1. 点击 "+" → "New repository"
echo   2. 仓库名：scanner-app
echo   3. 点击 "Create repository"
echo   4. 点击 "uploading an existing file"
echo   5. 拖入整个项目文件夹
echo   6. 点击 "Commit changes"
echo.
echo ┌────────────────────────────────────┐
echo │ 步骤 3：自动编译并下载 APK         │
echo └────────────────────────────────────┘
echo   1. 点击顶部 "Actions" 标签
echo   2. 等待编译完成（约8分钟）
echo   3. 点击 "Releases" 下载 APK
echo.
echo ════════════════════════════════════════
echo.
set /p choice="是否打开 GitHub 网站？(Y/N): "
if /i "%choice%"=="Y" (
    start https://github.com
)
echo.
echo 详细教程请查看：
echo   GitHub自动编译教程.md
echo.
pause
exit

:success
echo.
echo ════════════════════════════════════════
echo          ✓ 编译成功！
echo ════════════════════════════════════════
echo.
echo APK 文件位置：
echo %~dp0app\build\outputs\apk\debug\app-debug.apk
echo.
echo 登录信息：
echo   用户名：admin
echo   密码：admin
echo.
echo 正在打开 APK 所在文件夹...
start explorer "%~dp0app\build\outputs\apk\debug"
echo.
pause
