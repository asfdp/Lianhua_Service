import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';
import 'package:lianhua/core/services/navigation_service.dart';
import 'package:lianhua/features/home/presentation/main_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // 为启动页面设置特定的状态栏样式
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // 深色图标，适合浅色背景
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // 初始化动画控制器
    _fadeController = AnimationController(
      duration: AppConstants.longAnimationDuration,
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    // 创建动画
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // 启动动画
    _fadeController.forward();
    Future.delayed(AppConstants.mediumAnimationDuration, () {
      _slideController.forward();
    });

    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      NavigationService.replacePage(context, MainContainer());
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            // 背景装饰
            _buildBackgroundDecoration(),

            // 主要内容
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.pageMargin),
                child: Center(
                  child: Column(
                    children: [
                      // 顶部留白
                      Spacer(flex: 2),

                      // Logo部分
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: _buildLogo(),
                        ),
                      ),

                      // 中间留白
                      SizedBox(height: AppConstants.moduleSpacing),

                      // 标语部分
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: _buildSlogan(),
                        ),
                      ),

                      // 底部留白
                      Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建Logo
  Widget _buildLogo() {
    return Container(
      child: Image.asset(
        'assets/images/splash_logo.png',
        width: 240,
        height: 120,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // 如果图片加载失败，显示文字logo
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppConstants.sectionSpacing),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: AppConstants.shadowBlurRadius,
                      spreadRadius: AppConstants.shadowSpreadRadius,
                      offset: AppConstants.shadowOffset,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.home,
                  size: AppConstants.extraLargeIconSize + 12,
                  color: AppColors.primaryButtonText,
                ),
              ),
              SizedBox(height: AppConstants.paragraphSpacing),
              Text(
                '莲花物业集团',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConstants.lineSpacing),
              Text(
                '昆明',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.assistantColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 构建标语
  Widget _buildSlogan() {
    return Container(
      child: Image.asset(
        'assets/images/splash_slogan.png',
        width: 200,
        height: 60,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // 如果图片加载失败，显示文字标语
          return Column(
            children: [
              Text(
                '一颗诚心',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppConstants.lineSpacing),
              Text(
                '所有责任',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  // 构建背景装饰
  Widget _buildBackgroundDecoration() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 200,
        child: CustomPaint(painter: WavesPainter(), size: Size.infinite),
      ),
    );
  }
}

// 波浪装饰画笔
class WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final path = Path();

    // 第一层波浪
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // 第二层波浪
    final paint2 = Paint()
      ..color = AppColors.primaryVariant1.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.8);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.6,
      size.width * 0.6,
      size.height * 0.7,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
