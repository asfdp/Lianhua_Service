import 'package:flutter/material.dart';

import 'package:lianhua/core/widgets/dynamic_banner_widget.dart';
import 'package:lianhua/core/widgets/menu_grid_widget.dart';
import 'package:lianhua/core/widgets/notification_widget.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';
import 'package:lianhua/core/theme/festival_theme_manager.dart';
import 'package:lianhua/core/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 通知数据
  final List<NotificationItem> _notifications = [
    NotificationItem(title: '缴费提醒', content: '2025年1月物业管理费缴费提醒', time: '2小时前'),
    NotificationItem(title: '保洁工作通知', content: '1月保洁时间日程安排', time: '1月10日'),
    NotificationItem(title: '服务升级', content: '2025年1月滇池卫城物业服务升级', time: '1月8日'),
    NotificationItem(title: '保洁工作通知', content: '1月保洁时间日程安排', time: '1月10日'),
    NotificationItem(title: '服务升级', content: '2025年1月滇池卫城物业服务升级', time: '1月8日'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 顶部导航栏
          _buildTopBar(),

          // 轮播图
          DynamicBannerWidget(
            height: AppConstants.bannerHeight,
            autoPlayDuration: AppConstants.bannerAutoPlayDuration,
            onBannerTap: () {
              // 可以在这里处理轮播图点击事件
              print('轮播图被点击');
            },
          ),

          //  节日提示卡片
          _buildFestivalCard(),

          // 功能菜单
          _buildMenuSection(),

          // 底部消息提醒
          NotificationWidget(
            title: '物业公告',
            notifications: _notifications,
            unreadCount: 3,
          ),

          // 底部间距
          SizedBox(height: AppConstants.moduleSpacing),
        ],
      ),
    );
  }

  // 顶部导航栏
  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.pageMargin,
        vertical: AppConstants.paragraphSpacing,
      ),
      child: SafeArea(
        bottom: true,
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.accentColor,
              size: AppConstants.mediumIconSize,
            ),
            SizedBox(width: AppConstants.lineSpacing),
            Text(
              AppConstants.communityName,
              style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(width: AppConstants.lineSpacing / 2),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.secondaryTextColor,
              size: AppConstants.mediumIconSize,
            ),
            Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                NavigationService.navigateToMessageList(context);
              },
              child: Container(
                padding: EdgeInsets.all(AppConstants.lineSpacing),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.accentColor,
                  size: AppConstants.mediumIconSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  节日提示卡片
  Widget _buildFestivalCard() {
    final currentFestival = FestivalThemeManager.getCurrentFestival();

    // 如果是平常日子，不显示节日卡片
    if (currentFestival == FestivalType.normal) {
      return SizedBox.shrink();
    }

    final festivalName = FestivalThemeManager.getFestivalName(currentFestival);
    final festivalGreeting = FestivalThemeManager.getFestivalGreeting(
      currentFestival,
    );

    return Container(
      margin: EdgeInsets.fromLTRB(
        AppConstants.pageMargin,
        AppConstants.cardSpacing,
        AppConstants.pageMargin,
        AppConstants.cardSpacing,
      ),
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor.withValues(alpha: 0.9),
            AppColors.assistantColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: AppConstants.shadowBlurRadius,
            spreadRadius: AppConstants.shadowSpreadRadius,
            offset: AppConstants.shadowOffset,
          ),
        ],
      ),
      child: Row(
        children: [
          // 节日图标
          Container(
            padding: EdgeInsets.all(AppConstants.paragraphSpacing),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getFestivalIcon(currentFestival),
              color: Colors.white,
              size: AppConstants.largeIconSize,
            ),
          ),
          SizedBox(width: AppConstants.pageMargin),

          // 节日信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festivalName,
                  style: AppTextStyles.h1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppConstants.lineSpacing),
                Text(
                  festivalGreeting,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),

          // 装饰性图标
          Icon(
            Icons.celebration,
            color: Colors.white.withValues(alpha: 0.7),
            size: AppConstants.mediumIconSize,
          ),
        ],
      ),
    );
  }

  // 获取节日对应的图标
  IconData _getFestivalIcon(FestivalType festival) {
    switch (festival) {
      case FestivalType.newYear:
        return Icons.celebration;
      case FestivalType.springFestival:
        return Icons.stars;
      case FestivalType.qingming:
        return Icons.nature;
      case FestivalType.laborDay:
        return Icons.construction;
      case FestivalType.dragonBoat:
        return Icons.rowing;
      case FestivalType.midAutumn:
        return Icons.brightness_3;
      case FestivalType.nationalDay:
        return Icons.flag;
      case FestivalType.christmas:
        return Icons.cake;
      default:
        return Icons.event;
    }
  }

  // 功能菜单区域
  Widget _buildMenuSection() {
    final colors = AppColors.getMenuColors();
    final menuItems = AppConstants.menuTitles.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return MenuItem(
        title: item['title']!,
        color: colors[index % colors.length],
        onTap: () => _handleMenuTap(item['title']!),
      );
    }).toList();

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.pageMargin,
        vertical: AppConstants.cardSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: AppConstants.lineSpacing)),
          //SizedBox(height: AppConstants.lineSpacing),
          MenuGridWidget(menuItems: menuItems),
        ],
      ),
    );
  }

  // 处理菜单点击事件
  void _handleMenuTap(String title) {
    switch (title) {
      case '报事报修':
        NavigationService.navigateToRepair(context);
        break;
      case '物业收费':
        NavigationService.navigateToPayment(context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$title功能正在开发中',
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.accentColor,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(AppConstants.pageMargin),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
            ),
          ),
        );
    }
  }
}
