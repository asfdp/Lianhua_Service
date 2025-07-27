import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

/// P3 - 活动详情页（ActivityDetail）
/// 展示单个活动详情、报名按钮等
class ActivityDetailPage extends StatelessWidget {
  final Activity activity;
  const ActivityDetailPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 活动图片
            if (activity.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                child: Image.network(
                  activity.imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            if (activity.imageUrl.isNotEmpty)
              SizedBox(height: AppConstants.cardSpacing),
            // 标题
            Text(
              activity.title,
              style: AppTextStyles.title,
            ),
            SizedBox(height: AppConstants.lineSpacing),
            // 时间与状态
            Row(
              children: [
                Icon(Icons.event_outlined, color: AppColors.secondaryTextColor, size: 18),
                SizedBox(width: 4),
                Text(activity.formattedActivityTime, style: AppTextStyles.caption),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(int.parse(activity.status.colorHex.substring(1), radix: 16) + 0xFF000000),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    activity.status.displayName,
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.lineSpacing),
            // 地点
            if (activity.location.isNotEmpty)
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.secondaryTextColor, size: 18),
                  SizedBox(width: 4),
                  Text(activity.location, style: AppTextStyles.caption),
                ],
              ),
            if (activity.location.isNotEmpty)
              SizedBox(height: AppConstants.lineSpacing),
            // 参与人数
            Row(
              children: [
                Icon(Icons.people_outline, color: AppColors.secondaryTextColor, size: 18),
                SizedBox(width: 4),
                Text('已报名：${activity.currentParticipants}/${activity.maxParticipants > 0 ? activity.maxParticipants : '不限'}', style: AppTextStyles.caption),
              ],
            ),
            SizedBox(height: AppConstants.sectionSpacing),
            // 活动正文
            Text(
              activity.content,
              style: AppTextStyles.body,
            ),
            SizedBox(height: AppConstants.sectionSpacing),
            // 报名按钮
            if (activity.canRegister)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppConstants.primaryButtonStyle,
                  onPressed: () {
                    // TODO: 实现报名逻辑
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('报名成功！', style: AppTextStyles.bodyWhite),
                        backgroundColor: AppColors.successColor,
                      ),
                    );
                  },
                  child: Text('报名参加'),
                ),
              ),
            if (activity.isRegistered)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppConstants.primaryColorButtonStyle,
                  onPressed: null,
                  child: Text('已报名'),
                ),
              ),
            if (activity.isFull)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppConstants.primaryColorButtonStyle,
                  onPressed: null,
                  child: Text('已满员'),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 