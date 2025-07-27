class ApiConfig {
  // 开发环境
  static const String devBaseUrl = 'http://localhost:8080/api';
  
  // 测试环境
  static const String testBaseUrl = 'https://test-api.yourdomain.com/api';
  
  // 生产环境
  static const String prodBaseUrl = 'https://api.yourdomain.com/api';
  
  // 当前环境 - 根据需要修改
  static const String currentBaseUrl = devBaseUrl;
  
  // API端点
  static const String bannersEndpoint = '/banners';
  static const String noticesEndpoint = '/notices';
  static const String messagesEndpoint = '/messages';
  static const String activitiesEndpoint = '/activities';
  
  // 超时设置
  static const int connectionTimeout = 30; // 秒
  static const int receiveTimeout = 30; // 秒
  
  // 重试设置
  static const int maxRetries = 3;
  static const int retryDelay = 1000; // 毫秒
  
  // 缓存设置
  static const int cacheExpirationHours = 1; // 小时
  
  /// 获取完整的API URL
  static String getFullUrl(String endpoint) {
    return '$currentBaseUrl$endpoint';
  }
  
  /// 获取轮播图API URL
  static String getBannersUrl() {
    return getFullUrl(bannersEndpoint);
  }
  
  /// 获取单个轮播图API URL
  static String getBannerUrl(String id) {
    return getFullUrl('$bannersEndpoint/$id');
  }
} 