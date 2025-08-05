import 'package:flutter/material.dart';
import 'package:lianhua/core/services/navigation_service.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';

/// 页面基类 - 提供通用的页面功能和导航方法
abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

/// 页面状态基类
abstract class BasePageState<T extends BasePage> extends State<T> {
  bool _isLoading = false;
  String? _errorMessage;

  /// 是否正在加载
  bool get isLoading => _isLoading;

  /// 错误信息
  String? get errorMessage => _errorMessage;

  /// 设置加载状态
  void setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    }
  }

  /// 设置错误信息
  void setError(String? error) {
    if (mounted) {
      setState(() {
        _errorMessage = error;
      });
    }
  }

  /// 显示加载对话框
  void showLoadingDialog({String message = '加载中...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          ),
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
              ),
              SizedBox(width: AppConstants.paragraphSpacing),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 隐藏加载对话框
  void hideLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  /// 显示确认对话框
  Future<bool?> showConfirmDialog({
    required String title,
    required String content,
    String confirmText = '确认',
    String cancelText = '取消',
  }) {
    return NavigationService.showConfirmDialog(
      context,
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
    );
  }

  /// 显示选择对话框
  Future<T?> showSelectionDialog<T>({
    required String title,
    required List<MapEntry<String, T>> options,
  }) {
    return NavigationService.showSelectionDialog<T>(
      context,
      title: title,
      options: options,
    );
  }

  /// 显示底部弹窗
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return NavigationService.showBottomSheet<T>(
      context,
      child: child,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
    );
  }

  /// 显示成功提示
  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.successColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppConstants.pageMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        ),
      ),
    );
  }

  /// 显示错误提示
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.errorColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppConstants.pageMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        ),
      ),
    );
  }

  /// 显示警告提示
  void showWarningMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.warningColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppConstants.pageMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        ),
      ),
    );
  }

  /// 显示信息提示
  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
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

  /// 返回上一页
  void goBack<T extends Object?>([T? result]) {
    NavigationService.goBack<T>(result);
  }

  /// 返回上一页（带结果）
  void goBackWithResult<T extends Object?>(T result) {
    NavigationService.goBackWithResult<T>(context, result);
  }

  /// 返回到根页面
  void goToRoot() {
    NavigationService.goToRoot();
  }

  /// 返回到指定页面
  void popUntil(String routeName) {
    NavigationService.popUntil(routeName);
  }

  /// 替换当前页面
  Future<T?> replacePage<T extends Object?>(
    Widget page, {
    String? routeName,
  }) {
    return NavigationService.replacePage<T>(
      context,
      page,
      routeName: routeName,
    );
  }

  /// 替换所有页面
  Future<T?> replaceAllPages<T extends Object?>(
    Widget page, {
    String? routeName,
  }) {
    return NavigationService.replaceAllPages<T>(
      context,
      page,
      routeName: routeName,
    );
  }

  /// 使用命名路由导航
  Future<T?> navigateToNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return NavigationService.navigateToNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// 替换命名路由
  Future<T?> replaceNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return NavigationService.replaceNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// 构建错误页面
  Widget buildErrorPage({
    String? message,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.errorColor,
          ),
          SizedBox(height: AppConstants.paragraphSpacing),
          Text(
            message ?? '加载失败',
            style: AppTextStyles.h2.copyWith(
              color: AppColors.errorColor,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: AppConstants.paragraphSpacing),
            ElevatedButton(
              onPressed: onRetry,
              style: AppConstants.primaryButtonStyle,
              child: Text('重试'),
            ),
          ],
        ],
      ),
    );
  }

  /// 构建加载页面
  Widget buildLoadingPage({String message = '加载中...'}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
          ),
          SizedBox(height: AppConstants.paragraphSpacing),
          Text(
            message,
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建空状态页面
  Widget buildEmptyPage({
    required String message,
    IconData? icon,
    VoidCallback? onAction,
    String? actionText,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.inbox_outlined,
            size: 64,
            color: AppColors.secondaryTextColor,
          ),
          SizedBox(height: AppConstants.paragraphSpacing),
          Text(
            message,
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          if (onAction != null && actionText != null) ...[
            SizedBox(height: AppConstants.paragraphSpacing),
            ElevatedButton(
              onPressed: onAction,
              style: AppConstants.primaryButtonStyle,
              child: Text(actionText),
            ),
          ],
        ],
      ),
    );
  }
} 