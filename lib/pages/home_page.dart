import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/banner_widget.dart';
import '../widgets/menu_grid_widget.dart';
import '../widgets/notification_widget.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
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
      content: '2023年7月物业管理费缴费提醒',
      time: '4小时前',
    ),
    NotificationItem(
      title: '保洁工作通知',
      content: '7月保洁时间日程安排',
      time: '7月10日',
    ),
    NotificationItem(
      title: '服务升级',
      content: '2023年6月滇池卫城物业服务升级',
      time: '6月28日',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }



  // 顶部导航栏
  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 20),
          SizedBox(width: 8),
          Text(
            AppConstants.communityName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColors.grey600),
          Spacer(),
          Icon(Icons.message, color: AppColors.grey600),
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
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).primaryColor.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 节日图标
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getFestivalIcon(currentFestival),
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(width: 16),
          
          // 节日信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festivalName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  festivalGreeting,
                  style: TextStyle(
                    fontSize: 14,
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
            size: 24,
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
        color: colors[index],
        onTap: () => _handleMenuTap(item['title']!),
      );
    }).toList();

    return MenuGridWidget(menuItems: menuItems);
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
          SnackBar(content: Text('$title功能正在开发中')),
        );
    }
  }

} 