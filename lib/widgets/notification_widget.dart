import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

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
          SizedBox(height: AppConstants.paragraphSpacing),
          
          // 消息列表
          Column(
            children: notifications.take(3).map((notification) => 
              _buildNotificationItem(notification)
            ).toList(),
          ),
          
          // 查看更多按钮
          if (notifications.length > 3) ...[
            SizedBox(height: AppConstants.lineSpacing),
            _buildMoreButton(),
          ],
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
          title,
          style: AppTextStyles.h2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        if (unreadCount > 0) ...[
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
              unreadCount.toString(),
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
      padding: EdgeInsets.all(AppConstants.paragraphSpacing),
      decoration: BoxDecoration(
        color: notification.isRead ? AppColors.backgroundColor : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        border: Border.all(
          color: notification.isRead ? AppColors.dividerColor : AppColors.accentColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.lineSpacing,
            height: AppConstants.lineSpacing,
            decoration: BoxDecoration(
              color: notification.isRead ? AppColors.hintTextColor : AppColors.accentColor,
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
                    color: notification.isRead ? AppColors.secondaryTextColor : AppColors.primaryTextColor,
                  ),
                ),
                SizedBox(height: AppConstants.lineSpacing / 2),
                Text(
                  notification.content,
                  style: AppTextStyles.caption.copyWith(
                    color: notification.isRead ? AppColors.hintTextColor : AppColors.secondaryTextColor,
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

  Widget _buildMoreButton() {
    return GestureDetector(
      onTap: onMoreTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppConstants.paragraphSpacing),
        decoration: BoxDecoration(
          color: AppColors.primaryVariant1,
          borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
          border: Border.all(color: AppColors.dividerColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '查看更多消息',
              style: AppTextStyles.body.copyWith(
                color: AppColors.accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: AppConstants.lineSpacing),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.accentColor,
              size: AppConstants.smallIconSize,
            ),
          ],
        ),
      ),
    );
  }
} 