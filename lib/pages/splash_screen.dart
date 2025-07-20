import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/festival_theme_manager.dart';
import 'main_container.dart';


class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState() {
        super.initState();
        _navigateToHome();  
    }
    
    void _navigateToHome() async {
        await Future.delayed(Duration(seconds: 3));
        if (mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainContainer()),
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        // 🎊 获取当前节日信息
        final currentFestival = FestivalThemeManager.getCurrentFestival();
        final festivalName = FestivalThemeManager.getFestivalName(currentFestival);
        final festivalGreeting = FestivalThemeManager.getFestivalGreeting(currentFestival);
        
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        // 🎨 节日标题
                        Text(
                            festivalName,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                            ),
                        ),
                        SizedBox(height: 20),
                        
                        // 应用Logo
                        Icon(
                            Icons.home,
                            size: 100,
                            color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 20),
                        
                        // 应用名称
                        Text(
                            AppConstants.appTitle,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                            ),
                        ),
                        SizedBox(height: 30),
                        
                        // 🎊 节日问候语
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    width: 1,
                                ),
                            ),
                            child: Text(
                                festivalGreeting,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                ),
                                textAlign: TextAlign.center,
                            ),
                        ),
                        SizedBox(height: 40),
                        
                        // 加载指示器
                        CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}