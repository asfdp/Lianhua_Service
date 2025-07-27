# 导航解耦指南

## 概述

本项目已成功实现页面导航的完全解耦，通过创建统一的导航服务和路由配置，使页面间的跳转更加规范、可维护和可扩展。

## 架构设计

### 1. 导航服务 (NavigationService)

**位置**: `lib/services/navigation_service.dart`

**功能**:
- 统一管理所有页面跳转逻辑
- 提供全局导航键
- 支持带参数的页面跳转
- 提供对话框和底部弹窗导航
- 支持页面状态管理

**主要方法**:
```dart
// 基础页面导航
static Future<T?> navigateToRepair<T extends Object?>(BuildContext context)
static Future<T?> navigateToPayment<T extends Object?>(BuildContext context)
static Future<T?> navigateToMessageList<T extends Object?>(BuildContext context)

// 详情页面导航
static Future<T?> navigateToNoticeDetail<T extends Object?>(BuildContext context, Notice notice)
static Future<T?> navigateToMessageDetail<T extends Object?>(BuildContext context, Message message)
static Future<T?> navigateToActivityDetail<T extends Object?>(BuildContext context, Activity activity)

// 通用导航方法
static void goBack<T extends Object?>([T? result])
static void goToRoot()
static Future<T?> replacePage<T extends Object?>(BuildContext context, Widget page)
```

### 2. 路由配置 (RouteConfig)

**位置**: `lib/services/route_config.dart`

**功能**:
- 管理所有命名路由
- 处理带参数的路由跳转
- 提供未知路由处理
- 支持路由观察和分析

**路由常量**:
```dart
static const String splash = '/';
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
```

### 3. 页面基类 (BasePage)

**位置**: `lib/widgets/base_page.dart`

**功能**:
- 提供通用的页面功能
- 统一的加载状态管理
- 标准化的消息提示
- 通用的页面构建方法

**主要功能**:
```dart
// 状态管理
void setLoading(bool loading)
void setError(String? error)

// 消息提示
void showSuccessMessage(String message)
void showErrorMessage(String message)
void showWarningMessage(String message)
void showInfoMessage(String message)

// 页面构建
Widget buildErrorPage({String? message, VoidCallback? onRetry})
Widget buildLoadingPage({String message = '加载中...'})
Widget buildEmptyPage({required String message, IconData? icon})
```

## 使用指南

### 1. 页面跳转

**之前的方式**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => RepairPage()),
);
```

**现在的方式**:
```dart
NavigationService.navigateToRepair(context);
```

### 2. 带参数的页面跳转

**之前的方式**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MessageDetailPage(message: message),
  ),
);
```

**现在的方式**:
```dart
NavigationService.navigateToMessageDetail(context, message);
```

### 3. 返回上一页

**之前的方式**:
```dart
Navigator.pop(context);
```

**现在的方式**:
```dart
NavigationService.goBack(context);
```

### 4. 使用页面基类

**继承BasePage**:
```dart
class MyPage extends BasePage {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends BasePageState<MyPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return buildLoadingPage();
    }
    
    if (errorMessage != null) {
      return buildErrorPage(
        message: errorMessage,
        onRetry: _loadData,
      );
    }
    
    return Scaffold(
      body: // 你的页面内容
    );
  }
}
```

## 优势

### 1. 解耦性
- 页面不再直接依赖其他页面的导入
- 导航逻辑集中管理，便于维护
- 页面可以独立开发和测试

### 2. 可维护性
- 统一的导航接口，减少重复代码
- 路由配置集中管理，便于修改
- 错误处理统一化

### 3. 可扩展性
- 新增页面只需在导航服务中添加方法
- 支持路由参数的类型安全
- 便于添加路由中间件和拦截器

### 4. 类型安全
- 泛型支持确保类型安全
- 参数传递更加规范
- 编译时错误检查

## 最佳实践

### 1. 页面开发
- 优先继承BasePage基类
- 使用导航服务进行页面跳转
- 统一使用提供的消息提示方法

### 2. 路由管理
- 新增路由时在RouteConfig中添加常量
- 使用命名路由进行深度链接
- 合理使用路由参数

### 3. 错误处理
- 使用BasePageState提供的错误处理方法
- 统一错误页面样式
- 提供重试机制

### 4. 性能优化
- 合理使用路由观察器
- 避免不必要的页面重建
- 使用懒加载优化内存使用

## 迁移指南

### 1. 现有页面迁移
1. 移除直接的页面导入
2. 导入NavigationService
3. 替换Navigator.push为NavigationService方法
4. 替换Navigator.pop为NavigationService.goBack

### 2. 新增页面
1. 继承BasePage基类
2. 在NavigationService中添加导航方法
3. 在RouteConfig中添加路由配置
4. 使用统一的页面构建方法

## 注意事项

1. **导入管理**: 确保正确导入NavigationService
2. **类型安全**: 使用泛型确保类型安全
3. **错误处理**: 统一使用BasePageState的错误处理
4. **性能考虑**: 避免在导航方法中进行复杂计算
5. **测试**: 为导航服务编写单元测试

## 总结

通过导航解耦，我们实现了：
- ✅ 页面间完全解耦
- ✅ 统一的导航接口
- ✅ 类型安全的参数传递
- ✅ 标准化的错误处理
- ✅ 可扩展的路由系统
- ✅ 更好的代码可维护性

这种架构设计为项目的长期发展奠定了坚实的基础，使代码更加清晰、可维护和可扩展。 