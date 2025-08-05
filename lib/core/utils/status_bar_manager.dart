import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianhua/core/theme/app_colors.dart';

/// 状态栏管理工具类
/// 提供统一的状态栏样式配置，确保状态栏与APP界面颜色保持一致
class StatusBarManager {
  
  /// 默认状态栏样式 - 适用于浅色背景的页面
  static const SystemUiOverlayStyle lightStatusBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 深色图标
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  
  /// 深色状态栏样式 - 适用于深色背景的页面
  static const SystemUiOverlayStyle darkStatusBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // 白色图标
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  

  
  /// 主色调状态栏样式 - 适用于使用主色调背景的页面
  static const SystemUiOverlayStyle primaryStatusBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 深色图标，适合浅色主题
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  
  /// 强调色状态栏样式 - 适用于使用强调色背景的页面
  static const SystemUiOverlayStyle accentStatusBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // 白色图标，适合深色背景
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  
  /// 设置全局默认状态栏样式
  static void setGlobalStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(lightStatusBar);
  }
  
  /// 为浅色背景页面设置状态栏
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(lightStatusBar);
  }
  
  /// 为深色背景页面设置状态栏
  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(darkStatusBar);
  }
  

  
  /// 为主色调背景页面设置状态栏
  static void setPrimaryStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(primaryStatusBar);
  }
  
  /// 为强调色背景页面设置状态栏
  static void setAccentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(accentStatusBar);
  }
  
  /// 创建带状态栏样式的AnnotatedRegion包装器
  static Widget wrapWithStatusBar({
    required Widget child,
    SystemUiOverlayStyle? statusBarStyle,
  }) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle ?? lightStatusBar,
      child: child,
    );
  }
  
  /// 为不同类型的页面提供预设的包装器
  
  /// 浅色背景页面包装器
  static Widget wrapLightPage(Widget child) {
    return wrapWithStatusBar(
      child: child,
      statusBarStyle: lightStatusBar,
    );
  }
  
  /// 深色背景页面包装器  
  static Widget wrapDarkPage(Widget child) {
    return wrapWithStatusBar(
      child: child,
      statusBarStyle: darkStatusBar,
    );
  }
  

  
  /// 主色调背景页面包装器
  static Widget wrapPrimaryPage(Widget child) {
    return wrapWithStatusBar(
      child: child,
      statusBarStyle: primaryStatusBar,
    );
  }
  
  /// 强调色背景页面包装器
  static Widget wrapAccentPage(Widget child) {
    return wrapWithStatusBar(
      child: child,
      statusBarStyle: accentStatusBar,
    );
  }
} 