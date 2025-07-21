import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // 字体家族 - 使用系统默认字体或PingFang SC
  static const String fontFamily = 'PingFang SC';
  
  // 标题 - 20sp，页面主标题
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
    height: 1.2,
    fontFamily: fontFamily,
  );

  // 一级标题 - 18sp，重要标题、导航
  static const TextStyle h1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
    height: 1.3,
    fontFamily: fontFamily,
  );

  // 二级标题 - 16sp，次级标题
  static const TextStyle h2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
    height: 1.4,
    fontFamily: fontFamily,
  );

  // 正文 - 14sp，正文、按钮、表单
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryTextColor,
    height: 1.5,
    fontFamily: fontFamily,
  );

  // 辅助文字 - 12sp，标签、导航、说明
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryTextColor,
    height: 1.4,
    fontFamily: fontFamily,
  );

  // 次要文字样式 - 使用次要文字颜色
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryTextColor,
    height: 1.5,
    fontFamily: fontFamily,
  );

  // 提示文字样式 - 使用提示文字颜色
  static const TextStyle hint = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.hintTextColor,
    height: 1.4,
    fontFamily: fontFamily,
  );

  // 兼容旧版本的样式名称
  static const TextStyle h3 = h2;              // 兼容：二级标题
  static const TextStyle bodyLarge = h1;       // 兼容：一级标题
  static const TextStyle bodyMedium = body;    // 兼容：正文
  static const TextStyle bodySmall = bodySecondary; // 兼容：次要文字

  // Label - 10sp，角标数字
  static const TextStyle label = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 1.2,
    fontFamily: fontFamily,
  );

  // 带颜色变种的样式
  
  // 强调色文字样式
  static TextStyle titleAccent = title.copyWith(color: AppColors.accentColor);
  static TextStyle h1Accent = h1.copyWith(color: AppColors.accentColor);
  static TextStyle h2Accent = h2.copyWith(color: AppColors.accentColor);
  static TextStyle bodyAccent = body.copyWith(color: AppColors.accentColor);
  
  // 辅助色文字样式
  static TextStyle titleAssistant = title.copyWith(color: AppColors.assistantColor);
  static TextStyle h1Assistant = h1.copyWith(color: AppColors.assistantColor);
  static TextStyle bodyAssistant = body.copyWith(color: AppColors.assistantColor);
  static TextStyle captionAssistant = caption.copyWith(color: AppColors.assistantColor);
  
  // 白色文字样式（用于深色背景）
  static TextStyle titleWhite = title.copyWith(color: Colors.white);
  static TextStyle h1White = h1.copyWith(color: Colors.white);
  static TextStyle h2White = h2.copyWith(color: Colors.white);
  static TextStyle bodyWhite = body.copyWith(color: Colors.white);
  
  // 错误状态文字样式
  static TextStyle bodyError = body.copyWith(color: AppColors.errorColor);
  static TextStyle captionError = caption.copyWith(color: AppColors.errorColor);
  
  // 成功状态文字样式
  static TextStyle bodySuccess = body.copyWith(color: AppColors.successColor);
  static TextStyle captionSuccess = caption.copyWith(color: AppColors.successColor);

  // 兼容旧版本的带颜色样式
  static TextStyle bodyLargeAccent = h1Accent;
  static TextStyle bodyMediumAccent = bodyAccent;
  static TextStyle bodyLargeAssistant = h1Assistant;
  static TextStyle bodyMediumAssistant = bodyAssistant;
  static TextStyle bodyLargeWhite = h1White;
  static TextStyle bodyMediumWhite = bodyWhite;
  static TextStyle bodyMediumError = bodyError;
  static TextStyle bodyMediumSuccess = bodySuccess;
} 