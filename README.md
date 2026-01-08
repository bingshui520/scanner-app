# 📱 扫描APP

一个功能完整的安卓扫描应用，支持二维码和条形码扫描。

## ✨ 功能特点

- ✅ 用户登录（admin/admin）
- ✅ 二维码/条形码扫描
- ✅ 扫描历史记录
- ✅ 彩色渐变UI设计
- ✅ Material Design风格
- ✅ 相机权限管理

## 🎨 界面设计

- 紫粉渐变登录页
- 多彩卡片式主界面
- Emoji图标点缀
- 圆角按钮设计

## 🚀 编译安装

### 方法一：Android Studio

1. 打开 Android Studio
2. File -> Open -> 选择此目录
3. 等待 Gradle 同步完成
4. 连接安卓设备或启动模拟器
5. 点击运行按钮（▶️）

### 方法二：命令行

```bash
# 编译 Debug 版本
gradlew assembleDebug

# APK 输出位置
# app/build/outputs/apk/debug/app-debug.apk
```

## 📱 使用说明

1. **登录**
   - 用户名: `admin`
   - 密码: `admin`

2. **扫描**
   - 点击"开始扫描"按钮
   - 允许相机权限
   - 对准二维码/条形码

3. **查看**
   - 扫描结果实时显示
   - 历史记录自动保存

## 🔧 技术栈

- Java
- Material Design Components
- ZXing 扫码库
- Android SDK 33

## 📋 系统要求

- 最低支持: Android 5.0 (API 21)
- 目标版本: Android 13 (API 33)
- 需要权限: 相机

## 📝 注意事项

1. 首次扫描需要授权相机权限
2. 建议在真机上测试扫描功能
3. 模拟器可能无法使用相机

## 🎯 账号信息

- 用户名: `admin`
- 密码: `admin`

---

**版本**: 1.0  
**更新时间**: 2026-01-08
