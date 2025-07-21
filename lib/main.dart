import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/main_container.dart';
import 'constants/app_constants.dart';
import 'utils/app_colors.dart';
import 'utils/status_bar_manager.dart';
import 'utils/festival_theme_manager.dart';
import 'pages/splash_screen.dart';

void main() {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 设置全局默认状态栏样式
  StatusBarManager.setGlobalStatusBar();
  
  runApp(MyApp());
}

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
      theme: festivalTheme.copyWith(
        // 添加应用栏主题，统一状态栏样式
        appBarTheme: AppBarTheme(
          // 设置AppBar的状态栏样式 - 使用深色状态栏（白色图标）
          systemOverlayStyle: StatusBarManager.darkStatusBar,
          backgroundColor: AppColors.accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        // 统一颜色配置
        primaryColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
