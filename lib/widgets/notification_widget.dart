import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String content;
  final String time;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.content,
    required this.time,
    this.isRead = false,
  });
}

class NotificationWidget extends StatelessWidget {
  final String title;
  final List<NotificationItem> notifications;
  final int unreadCount;
  final VoidCallback? onMoreTap;

  const NotificationWidget({
    Key? key,
    required this.title,
    required this.notifications,
    this.unreadCount = 0,
    this.onMoreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            SizedBox(height: 8),
            
            // 消息列表
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: notifications.map((notification) => 
                    _buildNotificationItem(notification)
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        Spacer(),
        if (unreadCount > 0) ...[
          Text(
            '更多消息未读',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              unreadCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: notification.isRead ? Colors.grey[400] : Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  notification.content,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            notification.time,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
} 