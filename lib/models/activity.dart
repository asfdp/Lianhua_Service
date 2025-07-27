/// 活动数据模型
class Activity {
  final String id;
  final String title;
  final String content;
  final String summary; // 活动摘要，用于列表显示
  final String imageUrl;
  final DateTime createTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final ActivityStatus status;
  final String location;
  final int maxParticipants;
  final int currentParticipants;
  final bool isRegistered; // 当前用户是否已报名

  Activity({
    required this.id,
    required this.title,
    required this.content,
    required this.summary,
    this.imageUrl = '',
    required this.createTime,
    this.startTime,
    this.endTime,
    this.status = ActivityStatus.upcoming,
    this.location = '',
    this.maxParticipants = 0,
    this.currentParticipants = 0,
    this.isRegistered = false,
  });

  /// 从JSON创建活动对象
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createTime: DateTime.parse(json['createTime'] ?? DateTime.now().toIso8601String()),
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      status: ActivityStatus.values.firstWhere(
        (e) => e.toString() == 'ActivityStatus.${json['status']}',
        orElse: () => ActivityStatus.upcoming,
      ),
      location: json['location'] ?? '',
      maxParticipants: json['maxParticipants'] ?? 0,
      currentParticipants: json['currentParticipants'] ?? 0,
      isRegistered: json['isRegistered'] ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
      'imageUrl': imageUrl,
      'createTime': createTime.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'status': status.toString().split('.').last,
      'location': location,
      'maxParticipants': maxParticipants,
      'currentParticipants': currentParticipants,
      'isRegistered': isRegistered,
    };
  }

  /// 创建副本并修改某些属性
  Activity copyWith({
    String? id,
    String? title,
    String? content,
    String? summary,
    String? imageUrl,
    DateTime? createTime,
    DateTime? startTime,
    DateTime? endTime,
    ActivityStatus? status,
    String? location,
    int? maxParticipants,
    int? currentParticipants,
    bool? isRegistered,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      imageUrl: imageUrl ?? this.imageUrl,
      createTime: createTime ?? this.createTime,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      location: location ?? this.location,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }

  /// 格式化创建时间显示
  String get formattedCreateTime {
    return '${createTime.year}年${createTime.month}月${createTime.day}日';
  }

  /// 格式化活动时间显示
  String get formattedActivityTime {
    if (startTime == null) return '';
    
    final start = startTime!;
    if (endTime == null) {
      return '${start.month}月${start.day}日 ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    }
    
    final end = endTime!;
    if (start.day == end.day) {
      return '${start.month}月${start.day}日 ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}-${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
    } else {
      return '${start.month}月${start.day}日-${end.month}月${end.day}日';
    }
  }

  /// 是否可以报名
  bool get canRegister {
    return status == ActivityStatus.upcoming && 
           !isRegistered && 
           currentParticipants < maxParticipants;
  }

  /// 是否已满员
  bool get isFull {
    return maxParticipants > 0 && currentParticipants >= maxParticipants;
  }
}

/// 活动状态枚举
enum ActivityStatus {
  upcoming,  // 即将开始
  ongoing,   // 进行中
  ended,     // 已结束
  cancelled, // 已取消
}

/// 活动状态扩展方法
extension ActivityStatusExtension on ActivityStatus {
  /// 获取状态显示名称
  String get displayName {
    switch (this) {
      case ActivityStatus.upcoming:
        return '即将开始';
      case ActivityStatus.ongoing:
        return '进行中';
      case ActivityStatus.ended:
        return '已结束';
      case ActivityStatus.cancelled:
        return '已取消';
    }
  }

  /// 获取状态颜色
  String get colorHex {
    switch (this) {
      case ActivityStatus.upcoming:
        return '#D4AF9A';
      case ActivityStatus.ongoing:
        return '#F19139';
      case ActivityStatus.ended:
        return '#999999';
      case ActivityStatus.cancelled:
        return '#FF0000';
    }
  }
} 