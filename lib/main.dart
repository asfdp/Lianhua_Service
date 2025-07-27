import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/app_text_styles.dart';
import 'pages/main_container.dart';
import 'constants/app_constants.dart';
import 'utils/app_colors.dart';
import 'utils/status_bar_manager.dart';
import 'utils/festival_theme_manager.dart';
import 'pages/splash_screen.dart';
import 'services/navigation_service.dart';
import 'services/route_config.dart';

void main() {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 设置全局默认状态栏样式
  StatusBarManager.setGlobalStatusBar();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎊 获取当前节日类型
    final currentFestival = FestivalThemeManager.getCurrentFestival();
    
    // 🎨 根据节日获取对应主题
    final festivalTheme = FestivalThemeManager.getThemeByFestival(currentFestival);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey, // 使用导航服务的全局导航键
      navigatorObservers: [
        RouteConfig.routeObserver,
        RouteConfig.pageRouteObserver,
      ],
      
      // ✨ 应用节日主题，实现自动换肤
      theme: festivalTheme.copyWith(
        // 统一颜色配置
        primaryColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        cardColor: AppColors.cardBackground,
        dividerColor: AppColors.dividerColor,
        shadowColor: AppColors.shadowColor,
        textTheme: AppTextStyles.textTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppConstants.primaryButtonStyle,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppConstants.secondaryButtonStyle,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            borderSide: BorderSide(color: AppColors.accentColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            borderSide: BorderSide(color: AppColors.errorColor),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppConstants.pageMargin, 
            vertical: AppConstants.paragraphSpacing
          ),
          hintStyle: AppTextStyles.hint,
        ),
      ),
      
      // 路由配置
      routes: RouteConfig.getRoutes(),
      onGenerateRoute: RouteConfig.onGenerateRoute,
      onUnknownRoute: RouteConfig.onUnknownRoute,
      
      home: SplashScreen(),
    );
  }
}
