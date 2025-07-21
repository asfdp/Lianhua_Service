import 'package:flutter/material.dart';

class AppColors {
  // 新设计规范 - 主色系
  static const Color primaryColor = Color(0xFFFFF2E3);      // 主色调 #FFF2E3
  static const Color primaryVariant1 = Color(0xFFFAE7D5);   // 辅助色变体1 #FAE7D5
  static const Color primaryVariant2 = Color(0xFFF7E9DA);   // 辅助色变体2 #F7E9DA
  static const Color accentColor = Color(0xFFD4AF9A);       // 强调色 #D4AF9A  
  static const Color assistantColor = Color(0xFFC19A82);    // 辅助色 #C19A82
  
  // 背景颜色
  static const Color backgroundColor = Color(0xFFFFFFFF);    // 背景色 #FFFFFF（白色）
  static const Color cardBackground = Colors.white;
  
  // 分割线颜色
  static const Color dividerColor = Color(0xFFE0E0E0);      // 分割线颜色 #E0E0E0
  
  // 文字颜色（按新规范）
  static const Color primaryTextColor = Color(0xFF333333);   // 主要文字 #333333
  static const Color secondaryTextColor = Color(0xFF666666); // 次要文字 #666666
  static const Color hintTextColor = Color(0xFF999999);      // 提示文字 #999999
  
  // 兼容原有的蓝色主题（如果需要保留）
  static const Color primaryBlue = Color(0xFFF19139);
  static Color primaryBlueLight = Color(0x4DF19139);
  static Color primaryBlue200 = Color(0x4DF19139);
  static Color primaryBlue300 = Color(0x4DF19139);
  
  // 菜单颜色（使用新的主色系）
  static Color orange200 = primaryVariant1;
  static Color orange300 = primaryVariant2;
  static Color yellow200 = primaryColor;
  static Color yellow300 = primaryVariant1;
  static Color brown200 = assistantColor;
  static Color green200 = accentColor;
  
  // 灰色系
  static Color grey50 = Colors.grey[50]!;
  static Color grey200 = Colors.grey[200]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey800 = Colors.grey[800]!;
  
  // 状态色
  static const Color errorColor = Colors.red;
  static const Color warningColor = Colors.orange;
  static const Color successColor = Colors.green;
  
  // 阴影色
  static Color shadowColor = Colors.grey.withOpacity(0.1);
  
  // 按钮颜色
  static const Color primaryButtonBackground = primaryColor;     // 主要按钮背景
  static const Color primaryButtonText = Color(0xFFFFFFFF);     // 主要按钮文字（白色）
  static const Color secondaryButtonBackground = Colors.transparent; // 次要按钮背景（透明）
  static const Color secondaryButtonText = accentColor;         // 次要按钮文字
  static const Color secondaryButtonBorder = accentColor;       // 次要按钮边框
  
  // 获取菜单项颜色
  static List<Color> getMenuColors() {
    return [
      orange200, yellow200, brown200, orange300,
      primaryBlue200, orange200, green200, yellow300,
      orange200, orange200,
    ];
  }
} 