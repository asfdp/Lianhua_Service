import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../constants/api_config.dart';
import '../models/banner.dart';

class ApiService {
  // 超时时间
  static const Duration timeout = Duration(seconds: 30);

  // 获取轮播图列表
  static Future<List<BannerModel>> getBanners() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getBannersUrl()),
        headers: {
          'Content-Type': 'application/json',
          // 如果需要认证，在这里添加token
          // 'Authorization': 'Bearer $token',
        },
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<BannerModel> banners = data
            .map((json) => BannerModel.fromJson(json))
            .where((banner) => banner.isValid) // 只返回有效的轮播图
            .toList();
        
        // 按排序字段排序
        banners.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        
        return banners;
      } else {
        throw Exception('获取轮播图失败: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('网络连接失败，请检查网络设置');
    } on TimeoutException {
      throw Exception('请求超时，请稍后重试');
    } catch (e) {
      throw Exception('获取轮播图失败: $e');
    }
  }

  // 获取单个轮播图详情
  static Future<BannerModel?> getBannerById(String id) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getBannerUrl(id)),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return BannerModel.fromJson(data);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('获取轮播图详情失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('获取轮播图详情失败: $e');
    }
  }

  // 通用GET请求方法
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getFullUrl(endpoint)),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(timeout);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('请求失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('网络请求失败: $e');
    }
  }

  // 通用POST请求方法
  static Future<Map<String, dynamic>> post(
    String endpoint, 
    Map<String, dynamic> data
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.getFullUrl(endpoint)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      ).timeout(timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('请求失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('网络请求失败: $e');
    }
  }
} 