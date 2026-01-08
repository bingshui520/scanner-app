@echo off
echo ========================================
echo     扫描APP - APK 打包工具
echo ========================================
echo.

echo [步骤 1/3] 检查环境...
echo.

:: 检查是否安装了 Android Studio
if exist "C:\Program Files\Android\Android Studio\jre\bin\java.exe" (
    echo ✓ 检测到 Android Studio
    set JAVA_HOME=C:\Program Files\Android\Android Studio\jre
    goto build
)

if exist "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" (
    echo ✓ 检测到 Android SDK
    goto build
)

echo.
echo ========================================
echo   需要使用 Android Studio 打包
echo ========================================
echo.
echo 请按照以下步骤操作：
echo.
echo 1. 打开 Android Studio
echo 2. File -^> Open -^> 选择目录: %~dp0
echo 3. 等待 Gradle 同步完成
echo 4. Build -^> Build Bundle(s) / APK(s) -^> Build APK(s)
echo 5. 等待编译完成
echo.
echo APK 输出位置：
echo %~dp0app\build\outputs\apk\debug\app-debug.apk
echo.
echo ========================================
pause
exit /b 1

:build
echo [步骤 2/3] 开始编译...
echo.
echo 正在编译 APK，请稍候...
echo （首次编译可能需要几分钟下载依赖）
echo.

if exist "%~dp0gradlew.bat" (
    call "%~dp0gradlew.bat" assembleDebug
) else (
    echo 错误：找不到 gradlew.bat
    echo 请使用 Android Studio 打开项目进行编译
    pause
    exit /b 1
)

echo.
echo [步骤 3/3] 检查输出...
echo.

if exist "%~dp0app\build\outputs\apk\debug\app-debug.apk" (
    echo ========================================
    echo   ✓ APK 打包成功！
    echo ========================================
    echo.
    echo APK 文件位置：
    echo %~dp0app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 文件大小：
    for %%A in ("%~dp0app\build\outputs\apk\debug\app-debug.apk") do echo %%~zA 字节
    echo.
    echo 安装方式：
    echo 1. 将 APK 复制到手机
    echo 2. 在手机上点击安装
    echo 3. 首次安装需允许"未知来源"权限
    echo.
    echo 账号信息：
    echo 用户名: admin
    echo 密码: admin
    echo ========================================
) else (
    echo ========================================
    echo   ✗ APK 打包失败
    echo ========================================
    echo.
    echo 请使用 Android Studio 手动编译：
    echo 1. 打开 Android Studio
    echo 2. File -^> Open -^> %~dp0
    echo 3. Build -^> Build APK(s)
    echo ========================================
)

echo.
pause
