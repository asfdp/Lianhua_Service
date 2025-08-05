/// 消息数据模型
class Message {
  final String id;
  final String title;
  final String content;
  final String summary; // 消息摘要，用于列表显示
  final DateTime createTime;
  final bool isRead;
  final String senderName;
  final MessageType type;

  Message({
    required this.id,
    required this.title,
    required this.content,
    required this.summary,
    required this.createTime,
    this.isRead = false,
    required this.senderName,
    this.type = MessageType.system,
  });

  /// 从JSON创建消息对象
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      createTime: DateTime.parse(json['createTime'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
      senderName: json['senderName'] ?? '系统',
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${json['type']}',
        orElse: () => MessageType.system,
      ),
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
      'isRead': isRead,
      'senderName': senderName,
      'type': type.toString().split('.').last,
    };
  }

  /// 创建副本并修改某些属性
  Message copyWith({
    String? id,
    String? title,
    String? content,
    String? summary,
    DateTime? createTime,
    bool? isRead,
    String? senderName,
    MessageType? type,
  }) {
    return Message(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      createTime: createTime ?? this.createTime,
      isRead: isRead ?? this.isRead,
      senderName: senderName ?? this.senderName,
      type: type ?? this.type,
    );
  }

  /// 格式化时间显示
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(createTime);

    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${createTime.month}月${createTime.day}日';
    }
  }
}

/// 消息类型枚举
enum MessageType {
  system,    // 系统消息
  property,  // 物业通知
  payment,   // 缴费提醒
  repair,    // 报修回复
  activity,  // 活动通知
  other,     // 其他
}

/// 消息类型扩展方法
extension MessageTypeExtension on MessageType {
  /// 获取消息类型显示名称
  String get displayName {
    switch (this) {
      case MessageType.system:
        return '系统消息';
      case MessageType.property:
        return '物业通知';
      case MessageType.payment:
        return '缴费提醒';
      case MessageType.repair:
        return '报修回复';
      case MessageType.activity:
        return '活动通知';
      case MessageType.other:
        return '其他';
    }
  }

  /// 获取消息类型颜色
  String get colorHex {
    switch (this) {
      case MessageType.system:
        return '#666666';
      case MessageType.property:
        return '#D4AF9A';
      case MessageType.payment:
        return '#F19139';
      case MessageType.repair:
        return '#C19A82';
      case MessageType.activity:
        return '#FAE7D5';
      case MessageType.other:
        return '#999999';
    }
  }
} 