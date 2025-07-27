import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/repair_page.dart';
import '../pages/payment_page.dart';
import '../pages/message_list_page.dart';
import '../pages/notice_detail_page.dart';
import '../pages/message_detail_page.dart';
import '../pages/history_center_page.dart';
import '../pages/activity_detail_page.dart';
import '../pages/my_page.dart';
import '../pages/main_container.dart';
import '../utils/app_bar_usage_guide.dart';
import '../models/notice.dart';
import '../models/message.dart';
import '../models/activity.dart';

/// 路由配置服务 - 管理应用的所有命名路由
class RouteConfig {
  // 路由名称常量
  static const String main = '/main';
  static const String home = '/home';
  static const String repair = '/repair';
  static const String payment = '/payment';
  static const String messageList = '/message-list';
  static const String noticeDetail = '/notice-detail';
  static const String messageDetail = '/message-detail';
  static const String historyCenter = '/history-center';
  static const String activityDetail = '/activity-detail';
  static const String my = '/my';
  static const String appBarGuide = '/app-bar-guide';

  /// 获取所有路由配置
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      main: (context) => MainContainer(),
      home: (context) => HomePage(),
      repair: (context) => RepairPage(),
      payment: (context) => PaymentPage(),
      messageList: (context) => MessageListPage(),
      historyCenter: (context) => HistoryCenterPage(),
      my: (context) => MyPage(),
      appBarGuide: (context) => AppBarUsageGuidePage(),
    };
  }

  /// 获取带参数的路由配置
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case noticeDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final notice = args?['notice'] as Notice?;
        if (notice != null) {
          return MaterialPageRoute(
            builder: (context) => NoticeDetailPage(notice: notice),
          );
        }
        break;

      case messageDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final message = args?['message'] as Message?;
        if (message != null) {
          return MaterialPageRoute(
            builder: (context) => MessageDetailPage(message: message),
          );
        }
        break;

      case activityDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        final activity = args?['activity'] as Activity?;
        if (activity != null) {
          return MaterialPageRoute(
            builder: (context) => ActivityDetailPage(activity: activity),
          );
        }
        break;
    }
    return null;
  }

  /// 获取未知路由处理
  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                '页面不存在',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '请求的页面 ${settings.name} 不存在',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 路由观察器 - 用于路由分析和调试
  static RouteObserver<Route<dynamic>> routeObserver = RouteObserver<Route<dynamic>>();

  /// 路由分析器 - 用于路由性能分析
  static RouteObserver<PageRoute<dynamic>> pageRouteObserver = RouteObserver<PageRoute<dynamic>>();
} 