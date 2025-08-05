import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';

/// AppBar配置类 - 统一管理应用的导航栏样式
class AppBarConfig {
  /// 基础AppBar配置
  static AppBar basicAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? AppColors.primaryTextColor,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.cardBackground,
      foregroundColor: foregroundColor ?? AppColors.primaryTextColor,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      shape: Border(
        bottom: BorderSide(color: AppColors.dividerColor, width: 0.5),
      ),
    );
  }

  /// 主色调AppBar - 用于重要页面
  static AppBar primaryAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primaryTextColor,
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.primaryTextColor,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryColor, AppColors.primaryVariant1],
          ),
        ),
      ),
    );
  }

  /// 强调色AppBar - 用于重点功能页面
  static AppBar accentAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.accentColor,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      shadowColor: AppColors.accentColor.withValues(alpha: 0.3),
    );
  }

  /// 透明AppBar - 用于特殊页面（如个人中心）
  static AppBar transparentAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
    Color? titleColor,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: titleColor ?? Colors.white,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: titleColor == Colors.white
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: titleColor == Colors.white
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  /// 搜索AppBar - 带搜索功能
  static AppBar searchAppBar({
    required String title,
    required VoidCallback onSearchPressed,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primaryTextColor,
        ),
      ),
      backgroundColor: AppColors.cardBackground,
      foregroundColor: AppColors.primaryTextColor,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: onSearchPressed,
          tooltip: '搜索',
        ),
        if (actions != null) ...actions,
      ],
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      shape: Border(
        bottom: BorderSide(color: AppColors.dividerColor, width: 0.5),
      ),
    );
  }

  /// 带返回按钮的AppBar - 用于详情页面
  static AppBar backAppBar({
    required String title,
    required VoidCallback onBackPressed,
    List<Widget>? actions,
    bool centerTitle = true,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? AppColors.primaryTextColor,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.cardBackground,
      foregroundColor: foregroundColor ?? AppColors.primaryTextColor,
      elevation: 0,
      centerTitle: centerTitle,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed,
        tooltip: '返回',
      ),
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: foregroundColor == Colors.white
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: foregroundColor == Colors.white
            ? Brightness.dark
            : Brightness.light,
      ),
      shape: Border(
        bottom: BorderSide(color: AppColors.dividerColor, width: 0.5),
      ),
    );
  }

  /// 自定义AppBar - 完全自定义
  static PreferredSizeWidget customAppBar({
    required Widget child,
    double height = kToolbarHeight,
  }) {
    return PreferredSize(preferredSize: Size.fromHeight(height), child: child);
  }

  /// 渐变AppBar - 带渐变背景
  static AppBar gradientAppBar({
    required String title,
    required List<Color> gradientColors,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
    Color? foregroundColor,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: foregroundColor ?? Colors.white,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: foregroundColor == Colors.white
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: foregroundColor == Colors.white
            ? Brightness.dark
            : Brightness.light,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
      ),
    );
  }

  /// 常用的Action按钮
  static Widget notificationAction({
    required VoidCallback onPressed,
    int? badgeCount,
  }) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined),
          onPressed: onPressed,
          tooltip: '消息通知',
        ),
        if (badgeCount != null && badgeCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.errorColor,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                badgeCount > 99 ? '99+' : badgeCount.toString(),
                style: AppTextStyles.label,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  static Widget menuAction({required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: onPressed,
      tooltip: '更多',
    );
  }

  static Widget shareAction({required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(Icons.share_outlined),
      onPressed: onPressed,
      tooltip: '分享',
    );
  }

  static Widget settingsAction({required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(Icons.settings_outlined),
      onPressed: onPressed,
      tooltip: '设置',
    );
  }
}
