# 轮播图动态加载集成指南

## 概述

本指南介绍如何在Flutter应用中实现通过后端动态修改轮播图片的功能。

## 功能特性

- ✅ 支持网络图片和本地图片
- ✅ 自动缓存机制，离线可用
- ✅ 支持轮播图标题显示
- ✅ 支持点击跳转链接
- ✅ 支持时间控制（开始/结束时间）
- ✅ 支持排序和启用/禁用状态
- ✅ 加载状态和错误处理
- ✅ 自动轮播和手动控制

## 文件结构

```
lib/
├── models/
│   └── banner.dart              # 轮播图数据模型
├── services/
│   ├── api_service.dart         # API服务
│   └── banner_service.dart      # 轮播图服务管理器
├── constants/
│   └── api_config.dart          # API配置
├── widgets/
│   └── dynamic_banner_widget.dart # 动态轮播图组件
└── pages/
    └── home_page.dart           # 首页（已更新）
```

## 使用步骤

### 1. 安装依赖

确保在 `pubspec.yaml` 中添加了必要的依赖：

```yaml
dependencies:
  http: ^1.1.0
  shared_preferences: ^2.2.2
```

然后运行：
```bash
flutter pub get
```

### 2. 配置API地址

在 `lib/constants/api_config.dart` 中修改API地址：

```dart
// 修改为你的实际API地址
static const String currentBaseUrl = 'https://your-api-domain.com/api';
```

### 3. 在页面中使用

替换原有的 `BannerWidget` 为 `DynamicBannerWidget`：

```dart
import '../widgets/dynamic_banner_widget.dart';

// 在build方法中使用
DynamicBannerWidget(
  height: AppConstants.bannerHeight,
  autoPlayDuration: AppConstants.bannerAutoPlayDuration,
  onBannerTap: () {
    // 处理轮播图点击事件
    print('轮播图被点击');
  },
),
```

## 后端API要求

### 1. 轮播图列表接口

**URL:** `GET /api/banners`

**响应格式:**
```json
[
  {
    "id": "banner_001",
    "imageUrl": "https://example.com/images/banner1.jpg",
    "title": "小区环境展示",
    "linkUrl": "https://example.com/community-info",
    "sortOrder": 1,
    "isActive": true,
    "startTime": "2025-01-01T00:00:00Z",
    "endTime": "2025-12-31T23:59:59Z"
  }
]
```

### 2. 字段说明

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| id | String | 是 | 唯一标识 |
| imageUrl | String | 是 | 图片URL |
| title | String | 否 | 标题 |
| linkUrl | String | 否 | 跳转链接 |
| sortOrder | Integer | 否 | 排序 |
| isActive | Boolean | 否 | 是否启用 |
| startTime | String | 否 | 开始时间 |
| endTime | String | 否 | 结束时间 |

## 高级功能

### 1. 手动刷新轮播图

```dart
// 在需要刷新轮播图的地方调用
await BannerService().refreshBanners();
```

### 2. 监听轮播图数据变化

```dart
BannerService().bannerStream.listen((banners) {
  print('轮播图数据更新: ${banners.length} 张图片');
});
```

### 3. 清理缓存

```dart
// 清理轮播图缓存
await BannerService().clearCache();
```

### 4. 自定义轮播图点击处理

```dart
DynamicBannerWidget(
  onBannerTap: () {
    // 自定义点击处理逻辑
    final currentBanner = BannerService().currentBanners[currentIndex];
    if (currentBanner.linkUrl != null) {
      // 处理链接跳转
      _handleBannerLink(currentBanner.linkUrl!);
    }
  },
),
```

## 错误处理

系统会自动处理以下错误情况：

1. **网络连接失败**: 显示错误界面，提供重试按钮
2. **图片加载失败**: 显示默认错误图片
3. **API返回错误**: 使用缓存数据或默认数据
4. **缓存读取失败**: 使用默认轮播图数据

## 性能优化

1. **图片缓存**: 网络图片会自动缓存
2. **数据缓存**: 轮播图数据缓存1小时
3. **懒加载**: 图片按需加载
4. **内存管理**: 自动释放不需要的资源

## 测试建议

### 1. 网络测试

- 测试正常网络环境
- 测试网络断开情况
- 测试网络缓慢情况

### 2. 数据测试

- 测试空数据情况
- 测试无效数据情况
- 测试大量数据情况

### 3. 功能测试

- 测试自动轮播
- 测试手动滑动
- 测试点击跳转
- 测试时间控制

## 常见问题

### Q: 如何修改缓存时间？

A: 在 `BannerService` 中修改 `_cacheExpiration` 常量：

```dart
static const Duration _cacheExpiration = Duration(hours: 2); // 改为2小时
```

### Q: 如何添加认证头？

A: 在 `ApiService` 的请求头中添加：

```dart
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token',
},
```

### Q: 如何支持更多图片格式？

A: Flutter的 `Image.network` 和 `Image.asset` 支持常见的图片格式（PNG、JPG、GIF等）。

### Q: 如何自定义加载动画？

A: 修改 `DynamicBannerWidget` 中的 `_buildLoadingWidget()` 方法。

## 注意事项

1. 确保网络图片URL是可访问的
2. 图片大小建议控制在合理范围内（建议小于2MB）
3. 定期清理缓存以节省存储空间
4. 在生产环境中使用HTTPS协议
5. 考虑图片的CDN加速以提高加载速度 