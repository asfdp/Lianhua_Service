import 'package:flutter/material.dart';
import '../pages/repair_page.dart';
import '../pages/payment_page.dart';
import '../pages/message_list_page.dart';
import '../pages/notice_detail_page.dart';
import '../pages/message_detail_page.dart';
import '../pages/history_center_page.dart';
import '../pages/activity_detail_page.dart';
import '../models/notice.dart';
import '../models/message.dart';
import '../models/activity.dart';

/// 导航服务 - 统一管理页面跳转逻辑
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  /// 全局导航键
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 获取当前上下文
  BuildContext? get currentContext => navigatorKey.currentContext;

  /// 获取当前状态
  NavigatorState? get navigator => navigatorKey.currentState;

  // ==================== 页面导航方法 ====================

  /// 跳转到报事报修页面
  static Future<T?> navigateToRepair<T extends Object?>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => RepairPage()),
    );
  }

  /// 跳转到物业收费页面
  static Future<T?> navigateToPayment<T extends Object?>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => PaymentPage()),
    );
  }

  /// 跳转到消息列表页面
  static Future<T?> navigateToMessageList<T extends Object?>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => MessageListPage()),
    );
  }

  /// 跳转到历史中心页面
  static Future<T?> navigateToHistoryCenter<T extends Object?>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => HistoryCenterPage()),
    );
  }

  // ==================== 详情页面导航 ====================

  /// 跳转到公告详情页面
  static Future<T?> navigateToNoticeDetail<T extends Object?>(
    BuildContext context, 
    Notice notice
  ) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => NoticeDetailPage(notice: notice)),
    );
  }

  /// 跳转到消息详情页面
  static Future<T?> navigateToMessageDetail<T extends Object?>(
    BuildContext context, 
    Message message
  ) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => MessageDetailPage(message: message)),
    );
  }

  /// 跳转到活动详情页面
  static Future<T?> navigateToActivityDetail<T extends Object?>(
    BuildContext context, 
    Activity activity
  ) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(builder: (context) => ActivityDetailPage(activity: activity)),
    );
  }

  // ==================== 通用导航方法 ====================

  /// 返回上一页
  static void goBack<T extends Object?>([T? result]) {
    if (navigatorKey.currentState?.canPop() == true) {
      navigatorKey.currentState?.pop<T>(result);
    }
  }

  /// 返回上一页（带结果）
  static void goBackWithResult<T extends Object?>(BuildContext context, T result) {
    Navigator.pop<T>(context, result);
  }

  /// 返回到根页面
  static void goToRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  /// 返回到指定页面
  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // ==================== 替换页面导航 ====================

  /// 替换当前页面
  static Future<T?> replacePage<T extends Object?>(
    BuildContext context,
    Widget page, {
    String? routeName,
  }) {
    return Navigator.pushReplacement<T, void>(
      context,
      MaterialPageRoute<T>(
        builder: (context) => page,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
      ),
    );
  }

  /// 替换所有页面
  static Future<T?> replaceAllPages<T extends Object?>(
    BuildContext context,
    Widget page, {
    String? routeName,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute<T>(
        builder: (context) => page,
        settings: routeName != null ? RouteSettings(name: routeName) : null,
      ),
      (route) => false,
    );
  }

  // ==================== 命名路由导航 ====================

  /// 使用命名路由导航
  static Future<T?> navigateToNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    ) ?? Future.value(null);
  }

  /// 替换命名路由
  static Future<T?> replaceNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed<T, void>(
      routeName,
      arguments: arguments,
    ) ?? Future.value(null);
  }

  // ==================== 对话框导航 ====================

  /// 显示确认对话框
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = '确认',
    String cancelText = '取消',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// 显示选择对话框
  static Future<T?> showSelectionDialog<T>(
    BuildContext context, {
    required String title,
    required List<MapEntry<String, T>> options,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) => ListTile(
            title: Text(option.key),
            onTap: () => Navigator.pop(context, option.value),
          )).toList(),
        ),
      ),
    );
  }

  // ==================== 底部弹窗导航 ====================

  /// 显示底部弹窗
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = false,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      builder: (context) => child,
    );
  }

  // ==================== 页面状态管理 ====================

  /// 检查是否可以返回
  static bool canGoBack() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  /// 获取当前路由名称
  static String? getCurrentRouteName() {
    final currentRoute = navigatorKey.currentState?.widget.initialRoute;
    if (currentRoute != null) {
      return currentRoute;
    }
    
    // 如果无法获取初始路由，尝试从当前路由获取
    final currentContext = navigatorKey.currentContext;
    if (currentContext != null) {
      final route = ModalRoute.of(currentContext);
      return route?.settings.name;
    }
    
    return null;
  }

  /// 获取路由历史（只读，不会改变导航栈）
  static List<String> getRouteHistoryNames() {
    final routeNames = <String>[];
    final currentContext = navigatorKey.currentContext;
    if (currentContext != null) {
      // 通过遍历路由栈获取路由名称
      final route = ModalRoute.of(currentContext);
      if (route != null) {
        routeNames.add(route.settings.name ?? '');
      }
    }
    return routeNames;
  }

  /// 获取路由历史（会改变导航栈，谨慎使用）
  static List<Route<dynamic>> getRouteHistory() {
    final routes = <Route<dynamic>>[];
    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      // 注意：这个方法会改变导航栈，使用时要小心
      navigator.popUntil((route) {
        routes.add(route);
        return route.isFirst;
      });
      // 恢复导航栈
      for (int i = routes.length - 1; i > 0; i--) {
        navigator.push(routes[i]);
      }
    }
    return routes.reversed.toList();
  }
} 