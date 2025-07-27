import 'package:flutter/material.dart';
import '../models/notice.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

/// P4 - 公告详情页（NoticeDetail）
/// 展示单条公告全文
class NoticeDetailPage extends StatelessWidget {
  final Notice notice;
  const NoticeDetailPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              notice.title,
              style: AppTextStyles.title,
            ),
            SizedBox(height: AppConstants.lineSpacing),
            // 发布者和时间
            Row(
              children: [
                Icon(Icons.account_balance_outlined, color: AppColors.secondaryTextColor, size: 18),
                SizedBox(width: 4),
                Text(notice.publisherName, style: AppTextStyles.caption),
                Spacer(),
                Icon(Icons.access_time_outlined, color: AppColors.secondaryTextColor, size: 16),
                SizedBox(width: 2),
                Text(notice.fullFormattedTime, style: AppTextStyles.caption),
              ],
            ),
            SizedBox(height: AppConstants.lineSpacing),
            // 类型与优先级
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(int.parse(notice.type.colorHex.substring(1), radix: 16) + 0xFF000000),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    notice.type.displayName,
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(int.parse(notice.priority.colorHex.substring(1), radix: 16) + 0xFF000000),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    notice.priority.displayName,
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.sectionSpacing),
            // 正文内容
            Text(
              notice.content,
              style: AppTextStyles.body,
            ),
            SizedBox(height: AppConstants.sectionSpacing),
            // 附件
            if (notice.hasAttachment)
              Row(
                children: [
                  Icon(Icons.attach_file, color: AppColors.accentColor, size: 20),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '附件：${notice.attachmentUrl}',
                      style: AppTextStyles.bodySecondary.copyWith(color: AppColors.accentColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.open_in_new, color: AppColors.accentColor, size: 20),
                    onPressed: () {
                      // TODO: 实现附件打开逻辑
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('打开附件：${notice.attachmentUrl}', style: AppTextStyles.bodyWhite),
                          backgroundColor: AppColors.accentColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
} 