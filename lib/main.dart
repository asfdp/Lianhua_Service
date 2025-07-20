import 'package:flutter/material.dart';
import 'pages/main_container.dart';
import 'constants/app_constants.dart';
import 'utils/app_colors.dart';
import 'utils/festival_theme_manager.dart';
import 'pages/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 🎊 获取当前节日类型
    final currentFestival = FestivalThemeManager.getCurrentFestival();
    
    // 🎨 根据节日获取对应主题
    final festivalTheme = FestivalThemeManager.getThemeByFestival(currentFestival);
    
    return MaterialApp(
      title: AppConstants.appTitle,
      
      // ✨ 应用节日主题，实现自动换肤
      theme: festivalTheme,
      
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
