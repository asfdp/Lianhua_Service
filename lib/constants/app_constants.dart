import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppConstants {
  // 应用信息
  static const String appName = '物业服务';
  static const String appVersion = '1.0.0';
  static const String appTitle = '莲花物业';
  static const String communityName = '滇池卫城';
  static const String userTitle = '滇池卫城业主';
  
  // 轮播图图片
  static const List<String> bannerImages = [
    'images/building.png',
    'images/skyline.png',
    'images/sea.png',
  ];
  
  // 功能菜单数据
  static const List<Map<String, String>> menuTitles = [
    {'title': '投票报修'},
    {'title': '物业收费'},
    {'title': '访客登记'},
    {'title': '车辆管理'},
    {'title': '便民信息'},
    {'title': '投诉建议'},
    {'title': '问卷调查'},
    {'title': '住户投票'},
    {'title': '装修申请'},
    {'title': '物品放行'},
  ];
  
  // 我的页面功能
  static const List<Map<String, String>> myPageItems = [
    {'title': '我的缴费', 'subtitle': '查看缴费记录'},
    {'title': '我的报修', 'subtitle': '查看报修记录'},
    {'title': '我的车辆', 'subtitle': '车辆信息管理'},
    {'title': '我的消息', 'subtitle': '查看所有消息'},
    {'title': '帮助中心', 'subtitle': '常见问题解答'},
  ];
  
  // 轮播图设置
  static const double bannerHeight = 150.0;
  static const Duration bannerAutoPlayDuration = Duration(milliseconds: 3000);
  static const Duration bannerAnimationDuration = Duration(milliseconds: 700);
  static const Duration bannerResumeDelay = Duration(milliseconds: 1000);
  
  // 底部导航设置
  static const double bottomNavigationHeight = 60.0;
  
  // 菜单设置
  static const double menuIconSize = 50.0;
  
  // 间距常量（按新设计规范）
  static const double pageMargin = 16.0;           // 页面边距：16dp
  static const double moduleSpacing = 24.0;        // 模块间距：24dp
  static const double lineSpacing = 6.0;           // 行间距：6dp
  static const double paragraphSpacing = 12.0;     // 文字段落间距：12dp
  static const double cardSpacing = 8.0;           // 卡片间距
  static const double sectionSpacing = 20.0;       // 区块间距
  
  // 按钮常量（按新设计规范）
  static const double buttonRadius = 8.0;          // 按钮圆角：8dp
  static const double buttonHeight = 48.0;         // 按钮高度：48dp
  static const double buttonBorderWidth = 1.0;     // 次要按钮边框：1dp
  static const double smallButtonHeight = 36.0;    // 小按钮高度
  static const double largeButtonHeight = 56.0;    // 大按钮高度
  
  // 圆角常量
  static const double cardRadius = 12.0;           // 卡片圆角
  static const double smallRadius = 4.0;           // 小圆角
  static const double mediumRadius = 8.0;          // 中等圆角
  static const double largeRadius = 16.0;          // 大圆角
  
  // 阴影常量
  static const double shadowBlurRadius = 8.0;      // 阴影模糊半径
  static const double shadowSpreadRadius = 0.0;    // 阴影扩散半径
  static const Offset shadowOffset = Offset(0, 2); // 阴影偏移
  
  // 图标尺寸
  static const double smallIconSize = 16.0;        // 小图标
  static const double mediumIconSize = 24.0;       // 中等图标
  static const double largeIconSize = 32.0;        // 大图标
  static const double extraLargeIconSize = 48.0;   // 超大图标
  
  // 主要按钮样式
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.accentColor,
    foregroundColor: AppColors.primaryButtonText,
    minimumSize: Size(double.infinity, buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
    ),
    elevation: 0,
    textStyle: AppTextStyles.body,
  );
  
  // 主色调背景按钮样式
  static ButtonStyle get primaryColorButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.primaryTextColor,
    minimumSize: Size(double.infinity, buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
    ),
    elevation: 0,
    textStyle: AppTextStyles.body,
  );
  
  // 次要按钮样式
  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    backgroundColor: AppColors.secondaryButtonBackground,
    foregroundColor: AppColors.secondaryButtonText,
    minimumSize: Size(double.infinity, buttonHeight),
    side: BorderSide(
      color: AppColors.secondaryButtonBorder, 
      width: buttonBorderWidth,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
    ),
    textStyle: AppTextStyles.body,
  );
  
  // 小按钮样式
  static ButtonStyle get smallButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.accentColor,
    foregroundColor: AppColors.primaryButtonText,
    minimumSize: Size(100, smallButtonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
    ),
    elevation: 0,
    textStyle: AppTextStyles.caption,
  );
  
  // 卡片装饰
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(cardRadius),
    border: Border.all(color: AppColors.dividerColor, width: 1),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: shadowBlurRadius,
        spreadRadius: shadowSpreadRadius,
        offset: shadowOffset,
      ),
    ],
  );
  
  // 主色调卡片装饰
  static BoxDecoration get primaryCardDecoration => BoxDecoration(
    color: AppColors.primaryColor,
    borderRadius: BorderRadius.circular(cardRadius),
    border: Border.all(color: AppColors.dividerColor, width: 1),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: shadowBlurRadius,
        spreadRadius: shadowSpreadRadius,
        offset: shadowOffset,
      ),
    ],
  );
  
  // 输入框装饰
  static InputDecoration get inputDecoration => InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
      borderSide: BorderSide(color: AppColors.dividerColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
      borderSide: BorderSide(color: AppColors.dividerColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
      borderSide: BorderSide(color: AppColors.accentColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(buttonRadius),
      borderSide: BorderSide(color: AppColors.errorColor),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: pageMargin, vertical: paragraphSpacing),
    hintStyle: AppTextStyles.hint,
  );
  
  // 动画持续时间
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 1500);
  
  // API相关常量
  static const int timeoutDuration = 30; // 超时时间（秒）
  static const int retryAttempts = 3;    // 重试次数
  
  // 分页常量
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
} 