class BannerModel {
  final String id;
  final String imageUrl;
  final String? title;
  final String? linkUrl;
  final int sortOrder;
  final bool isActive;
  final DateTime? startTime;
  final DateTime? endTime;

  BannerModel({
    required this.id,
    required this.imageUrl,
    this.title,
    this.linkUrl,
    this.sortOrder = 0,
    this.isActive = true,
    this.startTime,
    this.endTime,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'],
      linkUrl: json['linkUrl'],
      sortOrder: json['sortOrder'] ?? 0,
      isActive: json['isActive'] ?? true,
      startTime: json['startTime'] != null 
          ? DateTime.parse(json['startTime']) 
          : null,
      endTime: json['endTime'] != null 
          ? DateTime.parse(json['endTime']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'linkUrl': linkUrl,
      'sortOrder': sortOrder,
      'isActive': isActive,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }

  // 检查轮播图是否在有效期内
  bool get isValid {
    if (!isActive) return false;
    
    final now = DateTime.now();
    if (startTime != null && now.isBefore(startTime!)) return false;
    if (endTime != null && now.isAfter(endTime!)) return false;
    
    return true;
  }
} 