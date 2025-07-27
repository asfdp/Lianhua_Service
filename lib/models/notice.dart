/// 公告数据模型
class Notice {
  final String id;
  final String title;
  final String content;
  final String summary; // 公告摘要，用于列表显示
  final DateTime createTime;
  final NoticeType type;
  final NoticePriority priority;
  final String attachmentUrl; // 附件URL
  final String publisherName; // 发布人
  final bool isRead;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.summary,
    required this.createTime,
    this.type = NoticeType.general,
    this.priority = NoticePriority.normal,
    this.attachmentUrl = '',
    this.publisherName = '物业管理处',
    this.isRead = false,
  });

  /// 从JSON创建公告对象
  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      createTime: DateTime.parse(json['createTime'] ?? DateTime.now().toIso8601String()),
      type: NoticeType.values.firstWhere(
        (e) => e.toString() == 'NoticeType.${json['type']}',
        orElse: () => NoticeType.general,
      ),
      priority: NoticePriority.values.firstWhere(
        (e) => e.toString() == 'NoticePriority.${json['priority']}',
        orElse: () => NoticePriority.normal,
      ),
      attachmentUrl: json['attachmentUrl'] ?? '',
      publisherName: json['publisherName'] ?? '物业管理处',
      isRead: json['isRead'] ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
      'createTime': createTime.toIso8601String(),
      'type': type.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'attachmentUrl': attachmentUrl,
      'publisherName': publisherName,
      'isRead': isRead,
    };
  }

  /// 创建副本并修改某些属性
  Notice copyWith({
    String? id,
    String? title,
    String? content,
    String? summary,
    DateTime? createTime,
    NoticeType? type,
    NoticePriority? priority,
    String? attachmentUrl,
    String? publisherName,
    bool? isRead,
  }) {
    return Notice(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      createTime: createTime ?? this.createTime,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      publisherName: publisherName ?? this.publisherName,
      isRead: isRead ?? this.isRead,
    );
  }

  /// 格式化时间显示
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(createTime);

    if (difference.inDays < 1) {
      return '今天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${createTime.month}月${createTime.day}日';
    }
  }

  /// 完整时间显示
  String get fullFormattedTime {
    return '${createTime.year}年${createTime.month}月${createTime.day}日 ${createTime.hour.toString().padLeft(2, '0')}:${createTime.minute.toString().padLeft(2, '0')}';
  }

  /// 是否有附件
  bool get hasAttachment {
    return attachmentUrl.isNotEmpty;
  }
}

/// 公告类型枚举
enum NoticeType {
  general,     // 一般公告
  maintenance, // 维修通知
  payment,     // 缴费通知
  safety,      // 安全提醒
  event,       // 活动通知
  urgent,      // 紧急通知
}

/// 公告优先级枚举
enum NoticePriority {
  low,    // 低优先级
  normal, // 普通
  high,   // 高优先级
  urgent, // 紧急
}

/// 公告类型扩展方法
extension NoticeTypeExtension on NoticeType {
  /// 获取公告类型显示名称
  String get displayName {
    switch (this) {
      case NoticeType.general:
        return '一般公告';
      case NoticeType.maintenance:
        return '维修通知';
      case NoticeType.payment:
        return '缴费通知';
      case NoticeType.safety:
        return '安全提醒';
      case NoticeType.event:
        return '活动通知';
      case NoticeType.urgent:
        return '紧急通知';
    }
  }

  /// 获取公告类型颜色
  String get colorHex {
    switch (this) {
      case NoticeType.general:
        return '#D4AF9A';
      case NoticeType.maintenance:
        return '#F19139';
      case NoticeType.payment:
        return '#C19A82';
      case NoticeType.safety:
        return '#FF9800';
      case NoticeType.event:
        return '#FAE7D5';
      case NoticeType.urgent:
        return '#FF0000';
    }
  }
}

/// 公告优先级扩展方法
extension NoticePriorityExtension on NoticePriority {
  /// 获取优先级显示名称
  String get displayName {
    switch (this) {
      case NoticePriority.low:
        return '低';
      case NoticePriority.normal:
        return '普通';
      case NoticePriority.high:
        return '重要';
      case NoticePriority.urgent:
        return '紧急';
    }
  }

  /// 获取优先级颜色
  String get colorHex {
    switch (this) {
      case NoticePriority.low:
        return '#999999';
      case NoticePriority.normal:
        return '#666666';
      case NoticePriority.high:
        return '#F19139';
      case NoticePriority.urgent:
        return '#FF0000';
    }
  }
} 