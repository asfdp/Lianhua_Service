# AppBar导航栏配置使用教程

## 📚 概述

本教程详细介绍如何在Flutter项目中使用统一的AppBar导航栏配置系统。通过预定义的配置文件，您可以快速创建各种样式的导航栏，保持整个应用的视觉一致性。

## 🎯 配置文件结构

```
lib/utils/
├── app_bar_config.dart          # AppBar配置文件
├── app_bar_usage_guide.dart     # 使用指南和示例
├── app_colors.dart              # 颜色配置
└── app_text_styles.dart         # 文字样式配置
```

## 🔧 导入配置

在需要使用AppBar的页面中导入配置文件：

```dart
import '../utils/app_bar_config.dart';
```

## 📋 AppBar样式类型

### 1. 基础AppBar - `basicAppBar`
**适用场景：** 普通页面、列表页面

```dart
Scaffold(
  appBar: AppBarConfig.basicAppBar(
    title: '页面标题',
    actions: [
      AppBarConfig.notificationAction(
        onPressed: () => print('通知'),
        badgeCount: 3,
      ),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 白色背景
- 深色文字
- 底部边框
- 透明状态栏

### 2. 主色调AppBar - `primaryAppBar`
**适用场景：** 首页、重要功能页面

```dart
Scaffold(
  appBar: AppBarConfig.primaryAppBar(
    title: '首页',
    actions: [
      AppBarConfig.settingsAction(
        onPressed: () => print('设置'),
      ),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 主色调渐变背景
- 深色文字
- 无阴影

### 3. 强调色AppBar - `accentAppBar`
**适用场景：** 表单页面、功能操作页面

```dart
Scaffold(
  appBar: AppBarConfig.accentAppBar(
    title: '报事报修',
    actions: [
      AppBarConfig.shareAction(
        onPressed: () => print('分享'),
      ),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 强调色背景
- 白色文字
- 带阴影

### 4. 带返回按钮AppBar - `backAppBar`
**适用场景：** 详情页面、二级页面

```dart
Scaffold(
  appBar: AppBarConfig.backAppBar(
    title: '详情页面',
    onBackPressed: () => Navigator.pop(context),
    actions: [
      AppBarConfig.shareAction(onPressed: () {}),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 自定义返回按钮
- iOS风格返回图标
- 自定义返回逻辑

### 5. 搜索AppBar - `searchAppBar`
**适用场景：** 列表页面、可搜索页面

```dart
Scaffold(
  appBar: AppBarConfig.searchAppBar(
    title: '消息列表',
    onSearchPressed: () => print('搜索'),
    actions: [
      AppBarConfig.menuAction(onPressed: () {}),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 内置搜索按钮
- 标准样式
- 可添加额外操作

### 6. 渐变AppBar - `gradientAppBar`
**适用场景：** 特殊页面、个性化页面

```dart
Scaffold(
  appBar: AppBarConfig.gradientAppBar(
    title: '特殊页面',
    gradientColors: [
      AppColors.accentColor,
      AppColors.assistantColor,
    ],
    actions: [
      AppBarConfig.notificationAction(
        onPressed: () {},
        badgeCount: 5,
      ),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 自定义渐变背景
- 白色文字
- 可配置渐变颜色

### 7. 透明AppBar - `transparentAppBar`
**适用场景：** 个人中心、带背景图的页面

```dart
Scaffold(
  extendBodyBehindAppBar: true,  // 重要：让内容延伸到AppBar后面
  appBar: AppBarConfig.transparentAppBar(
    title: '个人中心',
    titleColor: Colors.white,
    actions: [
      AppBarConfig.settingsAction(onPressed: () {}),
    ],
  ),
  body: YourPageContent(),
)
```

**特点：**
- 透明背景
- 可自定义文字颜色
- 需要配合`extendBodyBehindAppBar: true`

## 🔘 常用Action按钮

### 通知按钮
```dart
AppBarConfig.notificationAction(
  onPressed: () => print('通知'),
  badgeCount: 3,  // 角标数量，null时不显示
)
```

### 菜单按钮
```dart
AppBarConfig.menuAction(
  onPressed: () => print('菜单'),
)
```

### 分享按钮
```dart
AppBarConfig.shareAction(
  onPressed: () => print('分享'),
)
```

### 设置按钮
```dart
AppBarConfig.settingsAction(
  onPressed: () => print('设置'),
)
```

## 📱 完整页面示例

### 报修页面示例
```dart
class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarConfig.accentAppBar(
        title: '报事报修',
        actions: [
          AppBarConfig.notificationAction(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('查看历史报修记录')),
              );
            },
            badgeCount: 2,
          ),
          AppBarConfig.menuAction(
            onPressed: () => _showMenu(context),
          ),
        ],
      ),
      body: YourPageContent(),
    );
  }

  void _showMenu(BuildContext context) {
    // 显示菜单逻辑
  }
}
```

### 缴费页面示例
```dart
class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarConfig.primaryAppBar(
        title: '物业缴费',
        actions: [
          AppBarConfig.notificationAction(
            onPressed: () => _showNotifications(),
            badgeCount: 1,
          ),
          AppBarConfig.settingsAction(
            onPressed: () => _showSettings(),
          ),
        ],
      ),
      body: YourPageContent(),
    );
  }
}
```

## 🎨 自定义配置

### 修改默认参数
所有AppBar方法都支持可选参数：

```dart
AppBarConfig.basicAppBar(
  title: '标题',
  centerTitle: false,         // 标题居左
  automaticallyImplyLeading: false,  // 不显示默认返回按钮
  backgroundColor: AppColors.primaryColor,  // 自定义背景色
  foregroundColor: Colors.white,            // 自定义前景色
  elevation: 4,               // 自定义阴影
)
```

### 完全自定义AppBar
```dart
AppBarConfig.customAppBar(
  height: 80,  // 自定义高度
  child: Container(
    // 你的自定义AppBar内容
    child: Center(
      child: Text('自定义AppBar'),
    ),
  ),
)
```

## 🚀 最佳实践

### 1. 保持一致性
- 同类型页面使用相同的AppBar样式
- 重要功能页面使用强调色AppBar
- 普通页面使用基础AppBar

### 2. 合理使用Action按钮
- 不要在AppBar中放置过多按钮（建议不超过3个）
- 重要功能放在最右侧
- 使用图标工具提示（tooltip）

### 3. 状态栏适配
- 配置文件已自动处理状态栏样式
- 透明AppBar需要特别注意内容布局

### 4. 响应式设计
- 在平板设备上可能需要调整AppBar高度
- 考虑横屏模式下的显示效果

## ❗ 常见问题

### Q: 为什么我的AppBar没有显示？
A: 确保：
1. 已正确导入 `app_bar_config.dart`
2. 在Scaffold中正确设置了appBar属性
3. 检查是否有其他Widget覆盖了AppBar

### Q: 透明AppBar下的内容被遮挡怎么办？
A: 设置 `extendBodyBehindAppBar: true` 并调整body的padding

### Q: 如何自定义AppBar的颜色？
A: 使用方法中的可选参数，或者在 `app_colors.dart` 中添加新的颜色定义

### Q: 能否在运行时动态切换AppBar样式？
A: 可以，通过setState()更新当前使用的AppBar配置方法

## 📞 技术支持

如果您在使用过程中遇到问题，请：
1. 检查是否按照教程正确配置
2. 查看控制台是否有错误信息
3. 参考项目中的示例页面代码

---

**版本信息：** v1.0.0  
**最后更新：** 2025年1月  
**作者：** Flutter开发团队 