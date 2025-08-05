import 'package:flutter/material.dart';
import 'package:lianhua/features/messages/data/message.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';

/// P2 - 消息详情页（MessageDetail）
/// 展示单条定向消息全文
class MessageDetailPage extends StatelessWidget {
  final Message message;
  const MessageDetailPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(message.title, style: AppTextStyles.h2),
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(message.title, style: AppTextStyles.title),
            SizedBox(height: AppConstants.lineSpacing),
            // 发送者和时间
            Row(
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.secondaryTextColor,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(message.senderName, style: AppTextStyles.caption),
                Spacer(),
                Icon(
                  Icons.access_time_outlined,
                  color: AppColors.secondaryTextColor,
                  size: 16,
                ),
                SizedBox(width: 2),
                Text(message.formattedTime, style: AppTextStyles.caption),
              ],
            ),
            SizedBox(height: AppConstants.sectionSpacing),
            // 正文内容
            Text(message.content, style: AppTextStyles.body),
          ],
        ),
      ),
    );
  }
}
