import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/banner.dart';
import 'api_service.dart';

class BannerService {
  static final BannerService _instance = BannerService._internal();
  factory BannerService() => _instance;
  BannerService._internal();

  // 缓存键
  static const String _cacheKey = 'banner_cache';
  static const String _lastUpdateKey = 'banner_last_update';
  
  // 缓存过期时间（1小时）
  static const Duration _cacheExpiration = Duration(hours: 1);
  
  // 当前轮播图数据
  List<BannerModel> _currentBanners = [];
  
  // 数据更新流控制器
  final StreamController<List<BannerModel>> _bannerController = 
      StreamController<List<BannerModel>>.broadcast();
  
  // 获取轮播图数据流
  Stream<List<BannerModel>> get bannerStream => _bannerController.stream;
  
  // 获取当前轮播图数据
  List<BannerModel> get currentBanners => List.unmodifiable(_currentBanners);

  /// 初始化服务，从缓存加载数据
  Future<void> initialize() async {
    await _loadFromCache();
    // 如果缓存为空或已过期，则从服务器获取
    if (_currentBanners.isEmpty || await _isCacheExpired()) {
      await refreshBanners();
    }
  }

  /// 从服务器刷新轮播图数据
  Future<void> refreshBanners() async {
    try {
      final banners = await ApiService.getBanners();
      await _updateBanners(banners);
    } catch (e) {
      print('刷新轮播图失败: $e');
      // 如果网络请求失败，保持使用缓存数据
      if (_currentBanners.isEmpty) {
        // 如果缓存也为空，使用默认数据
        _currentBanners = _getDefaultBanners();
        _bannerController.add(_currentBanners);
      }
    }
  }

  /// 更新轮播图数据
  Future<void> _updateBanners(List<BannerModel> banners) async {
    _currentBanners = banners;
    await _saveToCache(banners);
    _bannerController.add(banners);
  }

  /// 从缓存加载数据
  Future<void> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheData = prefs.getString(_cacheKey);
      
      if (cacheData != null) {
        final List<dynamic> jsonList = json.decode(cacheData);
        _currentBanners = jsonList
            .map((json) => BannerModel.fromJson(json))
            .where((banner) => banner.isValid)
            .toList();
        _bannerController.add(_currentBanners);
      }
    } catch (e) {
      print('加载缓存轮播图失败: $e');
      _currentBanners = [];
    }
  }

  /// 保存数据到缓存
  Future<void> _saveToCache(List<BannerModel> banners) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = banners.map((banner) => banner.toJson()).toList();
      await prefs.setString(_cacheKey, json.encode(jsonList));
      await prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('保存轮播图缓存失败: $e');
    }
  }

  /// 检查缓存是否过期
  Future<bool> _isCacheExpired() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastUpdate = prefs.getInt(_lastUpdateKey);
      if (lastUpdate == null) return true;
      
      final lastUpdateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
      return DateTime.now().difference(lastUpdateTime) > _cacheExpiration;
    } catch (e) {
      return true;
    }
  }

  /// 获取默认轮播图数据（当网络请求失败时使用）
  List<BannerModel> _getDefaultBanners() {
    return [
      BannerModel(
        id: 'default_1',
        imageUrl: 'images/building.png',
        title: '小区环境',
        sortOrder: 1,
      ),
      BannerModel(
        id: 'default_2',
        imageUrl: 'images/skyline.png',
        title: '城市风光',
        sortOrder: 2,
      ),
      BannerModel(
        id: 'default_3',
        imageUrl: 'images/sea.png',
        title: '自然风景',
        sortOrder: 3,
      ),
    ];
  }

  /// 清理缓存
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_lastUpdateKey);
      _currentBanners = [];
      _bannerController.add(_currentBanners);
    } catch (e) {
      print('清理轮播图缓存失败: $e');
    }
  }

  /// 释放资源
  void dispose() {
    _bannerController.close();
  }
} 