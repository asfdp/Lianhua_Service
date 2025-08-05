import 'package:flutter/material.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';
import 'dart:async'; // Added for Timer

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

class NotificationWidget extends StatefulWidget {
  final String title;
  final List<NotificationItem> notifications;
  final int unreadCount;
  final VoidCallback? onMoreTap;

  const NotificationWidget({
    super.key,
    required this.title,
    required this.notifications,
    this.unreadCount = 0,
    this.onMoreTap,
  });

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late ScrollController _scrollController;
  late Timer _scrollTimer;
  int _currentIndex = 0;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    if (widget.notifications.length <= 1) return;

    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

    _scrollTimer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        double currentOffset = _scrollController.offset;
        double singleListHeight = widget.notifications.length * 55.0;

        // 无限滚动逻辑
        if (currentOffset >= singleListHeight) {
          // 当滚动到第一个列表的末尾时，瞬间跳转到第二个列表的开始
          _scrollController.jumpTo(0);
        } else {
          // 正常滚动
          _scrollController.animateTo(
            currentOffset + 0.3, // 每次滚动0.3像素，实现平滑连续滚动
            duration: Duration(milliseconds: 30),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.pageMargin,
        vertical: AppConstants.cardSpacing,
      ),
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: AppConstants.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: AppConstants.lineSpacing),

          // 循环滚动的消息列表
          Container(
            height: 140.0, // 固定高度
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.notifications.length * 3, // 创建3倍长度的列表用于无限滚动
                  itemBuilder: (context, index) {
                    int actualIndex = index % widget.notifications.length;
                    return Container(
                      height: 55.0,
                      child: _buildNotificationItem(
                        widget.notifications[actualIndex],
                      ),
                    );
                  },
                ),
                // 滚动指示器
                // if (widget.notifications.length > 1)
                //   Positioned(
                //     right: 0,
                //     top: 0,
                //     bottom: 0,
                //     child: Container(
                //       width: 4,
                //       margin: EdgeInsets.symmetric(vertical: 8),
                //       decoration: BoxDecoration(
                //         color: AppColors.dividerColor,
                //         borderRadius: BorderRadius.circular(2),
                //       ),
                //       child: Stack(
                //         children: [
                //           Positioned(
                //             top:
                //                 (_scrollOffset /
                //                     (90.0 * widget.notifications.length)) *
                //                 (90.0 - 16),
                //             child: Container(
                //               width: 4,
                //               height: 90.0 / widget.notifications.length,
                //               decoration: BoxDecoration(
                //                 color: AppColors.accentColor,
                //                 borderRadius: BorderRadius.circular(2),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.campaign_outlined,
          color: AppColors.accentColor,
          size: AppConstants.mediumIconSize,
        ),
        SizedBox(width: AppConstants.lineSpacing),
        Text(
          widget.title, // Changed from title to widget.title
          style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w600),
        ),
        Spacer(),
        if (widget.unreadCount > 0) ...[
          // Changed from unreadCount to widget.unreadCount
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.lineSpacing,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.errorColor,
              borderRadius: BorderRadius.circular(AppConstants.smallRadius),
            ),
            child: Text(
              widget.unreadCount
                  .toString(), // Changed from unreadCount to widget.unreadCount
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.lineSpacing),
      padding: EdgeInsets.all(AppConstants.lineSpacing),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        border: Border.all(
          color: AppColors.accentColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.lineSpacing,
            height: AppConstants.lineSpacing,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: AppConstants.paragraphSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: AppConstants.lineSpacing / 2),
                Text(
                  notification.content,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppConstants.lineSpacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                notification.time,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.hintTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
