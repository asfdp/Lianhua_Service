import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // 字体家族 - 使用思源黑体 (Noto Sans SC)
  static const String fontFamily = 'Noto Sans SC';

  // 获取思源黑体TextStyle的基础方法
  static TextStyle _getNotoSansStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required double height,
  }) {
    return GoogleFonts.notoSansSc(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  // H1 大标题 - 24px (原28px-4)，页面主标题
  static TextStyle get h1 => _getNotoSansStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
    height: 1.2,
  );

  // H2 中标题 - 20px (原24px-4)，用户名、区域标题
  static TextStyle get h2 => _getNotoSansStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
    height: 1.3,
  );

  // H3 小标题 - 16px (原20px-4)，轮播标题、金额
  static TextStyle get h3 => _getNotoSansStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
    height: 1.4,
  );

  // Body Large - 14px (原18px-4)，重要标题、导航
  static TextStyle get bodyLarge => _getNotoSansStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryTextColor,
    height: 1.4,
  );

  // Body Medium - 12px (原16px-4)，正文、按钮、表单
  static TextStyle get bodyMedium => _getNotoSansStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryTextColor,
    height: 1.5,
  );

  // Body Small - 10px (原14px-4)，辅助文字、时间
  static TextStyle get bodySmall => _getNotoSansStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryTextColor,
    height: 1.5,
  );

  // Caption - 8px (原12px-4)，标签、导航、说明
  static TextStyle get caption => _getNotoSansStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryTextColor,
    height: 1.4,
  );

  // Label - 6px (原10px-4)，角标数字
  static TextStyle get label => _getNotoSansStyle(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 1.2,
  );

  // 兼容旧版本的样式名称
  static TextStyle get title => h3; // 兼容：小标题
  static TextStyle get h1Old => bodyLarge; // 兼容：重要标题
  static TextStyle get h2Old => bodyMedium; // 兼容：正文
  static TextStyle get body => bodyMedium; // 兼容：正文
  static TextStyle get bodySecondary => bodySmall; // 兼容：辅助文字

  // 提示文字样式 - 使用提示文字颜色
  static TextStyle get hint => _getNotoSansStyle(
    fontSize: 8,
    fontWeight: FontWeight.normal,
    color: AppColors.hintTextColor,
    height: 1.4,
  );

  // 带颜色变种的样式

  // 强调色文字样式
  static TextStyle get h1Accent => h1.copyWith(color: AppColors.accentColor);
  static TextStyle get h2Accent => h2.copyWith(color: AppColors.accentColor);
  static TextStyle get h3Accent => h3.copyWith(color: AppColors.accentColor);
  static TextStyle get bodyLargeAccent =>
      bodyLarge.copyWith(color: AppColors.accentColor);
  static TextStyle get bodyMediumAccent =>
      bodyMedium.copyWith(color: AppColors.accentColor);

  // 辅助色文字样式
  static TextStyle get h1Assistant =>
      h1.copyWith(color: AppColors.assistantColor);
  static TextStyle get h2Assistant =>
      h2.copyWith(color: AppColors.assistantColor);
  static TextStyle get h3Assistant =>
      h3.copyWith(color: AppColors.assistantColor);
  static TextStyle get bodyLargeAssistant =>
      bodyLarge.copyWith(color: AppColors.assistantColor);
  static TextStyle get bodyMediumAssistant =>
      bodyMedium.copyWith(color: AppColors.assistantColor);
  static TextStyle get captionAssistant =>
      caption.copyWith(color: AppColors.assistantColor);

  // 白色文字样式（用于深色背景）
  static TextStyle get h1White => h1.copyWith(color: Colors.white);
  static TextStyle get h2White => h2.copyWith(color: Colors.white);
  static TextStyle get h3White => h3.copyWith(color: Colors.white);
  static TextStyle get bodyLargeWhite =>
      bodyLarge.copyWith(color: Colors.white);
  static TextStyle get bodyMediumWhite =>
      bodyMedium.copyWith(color: Colors.white);

  // 错误状态文字样式
  static TextStyle get bodyMediumError =>
      bodyMedium.copyWith(color: AppColors.errorColor);
  static TextStyle get captionError =>
      caption.copyWith(color: AppColors.errorColor);

  // 成功状态文字样式
  static TextStyle get bodyMediumSuccess =>
      bodyMedium.copyWith(color: AppColors.successColor);
  static TextStyle get captionSuccess =>
      caption.copyWith(color: AppColors.successColor);

  // 兼容旧版本的带颜色样式
  static TextStyle get titleAccent => h3Accent;
  static TextStyle get h1OldAccent => bodyLargeAccent;
  static TextStyle get h2OldAccent => bodyMediumAccent;
  static TextStyle get bodyAccent => bodyMediumAccent;
  static TextStyle get titleAssistant => h3Assistant;
  static TextStyle get h1OldAssistant => bodyLargeAssistant;
  static TextStyle get bodyAssistant => bodyMediumAssistant;
  static TextStyle get titleWhite => h3White;
  static TextStyle get h1OldWhite => bodyLargeWhite;
  static TextStyle get h2OldWhite => bodyMediumWhite;
  static TextStyle get bodyWhite => bodyMediumWhite;
  static TextStyle get bodyError => bodyMediumError;
  static TextStyle get bodySuccess => bodyMediumSuccess;

  // 为MaterialApp主题提供的TextTheme
  static TextTheme get textTheme => TextTheme(
    displayLarge: h1, // 24px
    displayMedium: h2, // 20px
    displaySmall: h3, // 16px
    headlineLarge: bodyLarge, // 14px
    headlineMedium: bodyMedium, // 12px
    headlineSmall: bodySmall, // 10px
    titleLarge: bodyLarge, // 14px
    titleMedium: bodyMedium, // 12px
    titleSmall: bodySmall, // 10px
    bodyLarge: bodyLarge, // 14px
    bodyMedium: bodyMedium, // 12px
    bodySmall: bodySmall, // 10px
    labelLarge: bodyMedium, // 12px
    labelMedium: bodySmall, // 10px
    labelSmall: caption, // 8px
  );
}
