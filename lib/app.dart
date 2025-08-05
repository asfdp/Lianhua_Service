import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
import 'core/theme/festival_theme_manager.dart';
import 'core/services/navigation_service.dart';
import 'core/services/route_config.dart';
import 'features/splash/presentation/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentFestival = FestivalThemeManager.getCurrentFestival();
    final festivalTheme =
        FestivalThemeManager.getThemeByFestival(currentFestival);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      navigatorObservers: [
        RouteConfig.routeObserver,
        RouteConfig.pageRouteObserver,
      ],
      theme: festivalTheme.copyWith(
        primaryColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        cardColor: AppColors.cardBackground,
        dividerColor: AppColors.dividerColor,
        shadowColor: AppColors.shadowColor,
        textTheme: AppTextStyles.textTheme,
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: AppConstants.primaryButtonStyle),
        outlinedButtonTheme:
            OutlinedButtonThemeData(style: AppConstants.secondaryButtonStyle),
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
            vertical: AppConstants.paragraphSpacing,
          ),
          hintStyle: AppTextStyles.hint,
        ),
      ),
      routes: RouteConfig.getRoutes(),
      onGenerateRoute: RouteConfig.onGenerateRoute,
      onUnknownRoute: RouteConfig.onUnknownRoute,
      home: const SplashScreen(),
    );
  }
}

