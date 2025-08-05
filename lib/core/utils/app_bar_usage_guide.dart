import 'package:flutter/material.dart';
import 'package:lianhua/core/utils/app_bar_config.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';

/// AppBar使用指南
/// 
/// 本文件详细说明了如何在项目中使用各种AppBar样式
/// 包括使用场景、示例代码和最佳实践

class AppBarUsageGuide {
  
  /// 基础AppBar使用示例
  static Widget buildBasicExample() {
    return Scaffold(
      appBar: AppBarConfig.basicAppBar(
        title: '基础导航栏',
        actions: [
          AppBarConfig.notificationAction(
            onPressed: () {
              print('通知被点击');
            },
            badgeCount: 3,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('基础AppBar示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            Text('适用于：普通页面、列表页面', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// 主色调AppBar使用示例
  static Widget buildPrimaryExample() {
    return Scaffold(
      appBar: AppBarConfig.primaryAppBar(
        title: '主色调导航栏',
        actions: [
          AppBarConfig.settingsAction(
            onPressed: () {
              print('设置被点击');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('主色调AppBar示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            Text('适用于：首页、重要功能页面', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// 强调色AppBar使用示例
  static Widget buildAccentExample() {
    return Scaffold(
      appBar: AppBarConfig.accentAppBar(
        title: '强调色导航栏',
        actions: [
          AppBarConfig.shareAction(
            onPressed: () {
              print('分享被点击');
            },
          ),
          AppBarConfig.menuAction(
            onPressed: () {
              print('菜单被点击');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('强调色AppBar示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            Text('适用于：表单页面、功能操作页面', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// 带返回按钮AppBar使用示例
  static Widget buildBackExample() {
    return Scaffold(
      appBar: AppBarConfig.backAppBar(
        title: '详情页面',
        onBackPressed: () {
          print('返回被点击');
          // Navigator.of(context).pop();
        },
        actions: [
          AppBarConfig.shareAction(
            onPressed: () {
              print('分享被点击');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('带返回按钮AppBar示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            Text('适用于：详情页面、二级页面', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// 搜索AppBar使用示例
  static Widget buildSearchExample() {
    return Scaffold(
      appBar: AppBarConfig.searchAppBar(
        title: '搜索页面',
        onSearchPressed: () {
          print('搜索被点击');
        },
        actions: [
          AppBarConfig.menuAction(
            onPressed: () {
              print('菜单被点击');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('搜索AppBar示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            Text('适用于：列表页面、可搜索页面', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// 渐变AppBar使用示例
  static Widget buildGradientExample() {
    return Scaffold(
      appBar: AppBarConfig.gradientAppBar(
        title: '渐变导航栏',
        gradientColors: [
          AppColors.accentColor,
          AppColors.assistantColor,
        ],
        actions: [
          AppBarConfig.notificationAction(
            onPressed: () {
              print('通知被点击');
            },
            badgeCount: 5,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('渐变AppBar示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            Text('适用于：特殊页面、个性化页面', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// 透明AppBar使用示例（通常用于个人中心页面）
  static Widget buildTransparentExample() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarConfig.transparentAppBar(
        title: '个人中心',
        titleColor: Colors.white,
        actions: [
          AppBarConfig.settingsAction(
            onPressed: () {
              print('设置被点击');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.accentColor,
              AppColors.assistantColor,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('透明AppBar示例', style: AppTextStyles.h2.copyWith(color: Colors.white)),
              SizedBox(height: 16),
              Text('适用于：个人中心、带背景图的页面', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

/// AppBar使用指南页面
class AppBarUsageGuidePage extends StatelessWidget {
  const AppBarUsageGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConfig.basicAppBar(
        title: 'AppBar使用指南',
        actions: [
          AppBarConfig.menuAction(
            onPressed: () {
              _showAppBarMenu(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('AppBar配置指南', style: AppTextStyles.h1),
          SizedBox(height: 16),
          
          _buildGuideSection(
            title: '1. 基础AppBar',
            description: '最常用的导航栏样式，适用于普通页面',
            codeExample: '''
appBar: AppBarConfig.basicAppBar(
  title: '页面标题',
  actions: [
    AppBarConfig.notificationAction(
      onPressed: () => print('通知'),
      badgeCount: 3,
    ),
  ],
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildBasicExample()),
          ),
          
          _buildGuideSection(
            title: '2. 主色调AppBar',
            description: '使用主色调的导航栏，适用于首页等重要页面',
            codeExample: '''
appBar: AppBarConfig.primaryAppBar(
  title: '首页',
  actions: [
    AppBarConfig.settingsAction(
      onPressed: () => print('设置'),
    ),
  ],
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildPrimaryExample()),
          ),
          
          _buildGuideSection(
            title: '3. 强调色AppBar',
            description: '使用强调色的导航栏，适用于重点功能页面',
            codeExample: '''
appBar: AppBarConfig.accentAppBar(
  title: '报事报修',
  actions: [
    AppBarConfig.shareAction(
      onPressed: () => print('分享'),
    ),
  ],
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildAccentExample()),
          ),
          
          _buildGuideSection(
            title: '4. 带返回按钮AppBar',
            description: '带有自定义返回按钮的导航栏，适用于详情页面',
            codeExample: '''
appBar: AppBarConfig.backAppBar(
  title: '详情页面',
  onBackPressed: () => Navigator.pop(context),
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildBackExample()),
          ),
          
          _buildGuideSection(
            title: '5. 搜索AppBar',
            description: '带有搜索功能的导航栏，适用于列表页面',
            codeExample: '''
appBar: AppBarConfig.searchAppBar(
  title: '消息列表',
  onSearchPressed: () => print('搜索'),
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildSearchExample()),
          ),
          
          _buildGuideSection(
            title: '6. 渐变AppBar',
            description: '带有渐变背景的导航栏，适用于特殊页面',
            codeExample: '''
appBar: AppBarConfig.gradientAppBar(
  title: '特殊页面',
  gradientColors: [
    AppColors.accentColor,
    AppColors.assistantColor,
  ],
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildGradientExample()),
          ),
          
          _buildGuideSection(
            title: '7. 透明AppBar',
            description: '透明背景的导航栏，适用于个人中心等带背景的页面',
            codeExample: '''
extendBodyBehindAppBar: true,
appBar: AppBarConfig.transparentAppBar(
  title: '个人中心',
  titleColor: Colors.white,
),''',
            onTryPressed: () => _showExample(context, AppBarUsageGuide.buildTransparentExample()),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideSection({
    required String title,
    required String description,
    required String codeExample,
    required VoidCallback onTryPressed,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h3),
          SizedBox(height: 8),
          Text(description, style: AppTextStyles.bodyMedium),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              codeExample,
              style: AppTextStyles.bodySmall.copyWith(
                fontFamily: 'monospace',
                color: AppColors.primaryTextColor,
              ),
            ),
          ),
          SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onTryPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('查看示例', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _showExample(BuildContext context, Widget example) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => example),
    );
  }

  void _showAppBarMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('AppBar选项', style: AppTextStyles.h3),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('使用说明', style: AppTextStyles.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('选择上面的示例来查看不同AppBar样式')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.code),
                title: Text('查看源码', style: AppTextStyles.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('请查看 lib/utils/app_bar_config.dart 文件')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 