import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/banner_widget.dart';
import '../widgets/menu_grid_widget.dart';
import '../widgets/notification_widget.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/festival_theme_manager.dart';
import 'repair_page.dart';
import 'payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 通知数据
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: '缴费提醒',
      content: '2025年1月物业管理费缴费提醒',
      time: '2小时前',
    ),
    NotificationItem(
      title: '保洁工作通知',
      content: '1月保洁时间日程安排',
      time: '1月10日',
    ),
    NotificationItem(
      title: '服务升级',
      content: '2025年1月滇池卫城物业服务升级',
      time: '1月8日',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 顶部导航栏
          _buildTopBar(),
          
          // 轮播图
          BannerWidget(
            images: AppConstants.bannerImages,
            height: AppConstants.bannerHeight,
            autoPlayDuration: AppConstants.bannerAutoPlayDuration,
          ),
          
          // 🎊 节日提示卡片
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
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          bottom: BorderSide(color: AppColors.dividerColor, width: 1),
        ),
      ),
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
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: AppConstants.lineSpacing / 2),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.secondaryTextColor,
            size: AppConstants.mediumIconSize,
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(AppConstants.lineSpacing),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: AppColors.accentColor,
              size: AppConstants.mediumIconSize,
            ),
          ),
        ],
      ),
    );
  }

  // 🎊 节日提示卡片
  Widget _buildFestivalCard() {
    final currentFestival = FestivalThemeManager.getCurrentFestival();
    
    // 如果是平常日子，不显示节日卡片
    if (currentFestival == FestivalType.normal) {
      return SizedBox.shrink();
    }
    
    final festivalName = FestivalThemeManager.getFestivalName(currentFestival);
    final festivalGreeting = FestivalThemeManager.getFestivalGreeting(currentFestival);
    
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
            AppColors.accentColor.withOpacity(0.9),
            AppColors.assistantColor.withOpacity(0.8),
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
              color: Colors.white.withOpacity(0.2),
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
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          
          // 装饰性图标
          Icon(
            Icons.celebration,
            color: Colors.white.withOpacity(0.7),
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
          Padding(
            padding: EdgeInsets.only(left: AppConstants.lineSpacing),
            child: Text(
              '服务功能',
              style: AppTextStyles.h1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: AppConstants.paragraphSpacing),
          MenuGridWidget(menuItems: menuItems),
        ],
      ),
    );
  }

  // 处理菜单点击事件
  void _handleMenuTap(String title) {
    switch (title) {
      case '投票报修':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RepairPage()),
        );
        break;
      case '物业收费':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentPage()),
        );
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