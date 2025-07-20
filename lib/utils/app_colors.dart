import 'package:flutter/material.dart';

class AppColors {
  // 主题色 - 橙色主题
  static const Color primaryBlue = Color(0xFFF19139);
  static Color primaryBlueLight = Color(0x4DF19139);
  static Color primaryBlue200 = Color(0x4DF19139);
  static Color primaryBlue300 = Color(0x4DF19139);
  
  // 菜单颜色
  static Color orange200 = Colors.orange[200]!;
  static Color orange300 = Colors.orange[300]!;
  static Color yellow200 = Colors.yellow[200]!;
  static Color yellow300 = Colors.yellow[300]!;
  static Color brown200 = Colors.brown[200]!;
  static Color green200 = Colors.green[200]!;
  
  // 灰色系
  static Color grey50 = Colors.grey[50]!;
  static Color grey200 = Colors.grey[200]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey800 = Colors.grey[800]!;
  
  // 背景色
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  
  // 状态色
  static const Color errorColor = Colors.red;
  static const Color warningColor = Colors.orange;
  static const Color successColor = Colors.green;
  
  // 文本色
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF666666);
  static const Color hintTextColor = Color(0xFF999999);
  
  // 阴影色
  static Color shadowColor = Colors.grey.withOpacity(0.1);
  
  // 获取菜单项颜色
  static List<Color> getMenuColors() {
    return [
      orange200, yellow200, brown200, orange300,
      primaryBlue200, orange200, green200, yellow300,
      orange200, orange200,
    ];
  }
} 