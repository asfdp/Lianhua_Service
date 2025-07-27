# API 响应示例

## 轮播图API

### 获取轮播图列表

**请求URL:** `GET /api/banners`

**响应示例:**
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
  },
  {
    "id": "banner_002",
    "imageUrl": "https://example.com/images/banner2.jpg",
    "title": "物业服务介绍",
    "linkUrl": "https://example.com/service-info",
    "sortOrder": 2,
    "isActive": true,
    "startTime": "2025-01-01T00:00:00Z",
    "endTime": null
  },
  {
    "id": "banner_003",
    "imageUrl": "images/building.png",
    "title": "本地图片测试",
    "linkUrl": null,
    "sortOrder": 3,
    "isActive": true,
    "startTime": null,
    "endTime": null
  }
]
```

### 获取单个轮播图

**请求URL:** `GET /api/banners/{id}`

**响应示例:**
```json
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
```

## 字段说明

| 字段名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | String | 是 | 轮播图唯一标识 |
| imageUrl | String | 是 | 图片URL，支持网络图片和本地图片路径 |
| title | String | 否 | 轮播图标题，显示在图片底部 |
| linkUrl | String | 否 | 点击轮播图跳转的链接 |
| sortOrder | Integer | 否 | 排序顺序，数字越小越靠前 |
| isActive | Boolean | 否 | 是否启用，默认true |
| startTime | String | 否 | 开始时间，ISO 8601格式 |
| endTime | String | 否 | 结束时间，ISO 8601格式 |

## 图片URL说明

- **网络图片**: 以 `http://` 或 `https://` 开头的完整URL
- **本地图片**: 相对于assets目录的路径，如 `images/building.png`

## 时间格式

时间字段使用ISO 8601格式：`YYYY-MM-DDTHH:mm:ssZ`

例如：`2025-01-01T00:00:00Z`

## 错误响应

**400 Bad Request:**
```json
{
  "error": "Invalid request parameters",
  "message": "详细错误信息"
}
```

**404 Not Found:**
```json
{
  "error": "Banner not found",
  "message": "轮播图不存在"
}
```

**500 Internal Server Error:**
```json
{
  "error": "Internal server error",
  "message": "服务器内部错误"
}
``` 