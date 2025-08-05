import 'package:flutter/material.dart';
import 'package:lianhua/features/activities/data/activity.dart';
import 'package:lianhua/features/messages/data/notice.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';
import 'package:lianhua/core/services/navigation_service.dart';

/// P5 - 历史活动与公告页（HistoryCenter）
/// 按时间倒序列出“已结束活动+全部公告”
class HistoryCenterPage extends StatefulWidget {
  const HistoryCenterPage({super.key});

  @override
  _HistoryCenterPageState createState() => _HistoryCenterPageState();
}

class _HistoryCenterPageState extends State<HistoryCenterPage> {
  bool _isLoading = true;
  List<Activity> _activities = [];
  List<Notice> _notices = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// 加载历史活动和公告数据（模拟）
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // 模拟已结束活动
    final mockActivities = [
      Activity(
        id: 'a1',
        title: '2024年中秋晚会',
        content: '中秋晚会圆满结束，感谢大家参与！',
        summary: '2024年中秋晚会圆满结束',
        imageUrl: '',
        createTime: DateTime.now().subtract(Duration(days: 120)),
        startTime: DateTime.now().subtract(Duration(days: 121)),
        endTime: DateTime.now().subtract(Duration(days: 120)),
        status: ActivityStatus.ended,
        location: '小区会所',
        maxParticipants: 200,
        currentParticipants: 180,
        isRegistered: false,
      ),
      Activity(
        id: 'a2',
        title: '2024年国庆亲子运动会',
        content: '亲子运动会精彩纷呈，大家收获满满！',
        summary: '2024年国庆亲子运动会精彩回顾',
        imageUrl: '',
        createTime: DateTime.now().subtract(Duration(days: 90)),
        startTime: DateTime.now().subtract(Duration(days: 91)),
        endTime: DateTime.now().subtract(Duration(days: 90)),
        status: ActivityStatus.ended,
        location: '小区操场',
        maxParticipants: 100,
        currentParticipants: 95,
        isRegistered: false,
      ),
    ];
    // 模拟公告
    final mockNotices = [
      Notice(
        id: 'n1',
        title: '2024年国庆放假通知',
        content: '国庆期间物业服务时间调整，祝大家节日快乐！',
        summary: '国庆期间物业服务时间调整',
        createTime: DateTime.now().subtract(Duration(days: 92)),
        type: NoticeType.general,
        priority: NoticePriority.normal,
        attachmentUrl: '',
        publisherName: '物业管理处',
        isRead: true,
      ),
      Notice(
        id: 'n2',
        title: '2024年中秋节安全提醒',
        content: '中秋节期间注意用火用电安全，祝大家团圆美满！',
        summary: '中秋节期间安全提醒',
        createTime: DateTime.now().subtract(Duration(days: 121)),
        type: NoticeType.safety,
        priority: NoticePriority.high,
        attachmentUrl: '',
        publisherName: '物业管理处',
        isRead: true,
      ),
    ];
    setState(() {
      _activities = mockActivities;
      _notices = mockNotices;
      _isLoading = false;
    });
  }

  /// 合并并按时间倒序排列
  List<_HistoryItem> get _mergedHistoryList {
    final items = <_HistoryItem>[];
    items.addAll(_activities.map((a) => _HistoryItem.activity(a)));
    items.addAll(_notices.map((n) => _HistoryItem.notice(n)));
    items.sort((a, b) => b.time.compareTo(a.time));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.accentColor))
          : RefreshIndicator(
              onRefresh: _loadData,
              color: AppColors.accentColor,
              child: _mergedHistoryList.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.all(AppConstants.pageMargin),
                      itemCount: _mergedHistoryList.length,
                      itemBuilder: (context, index) {
                        final item = _mergedHistoryList[index];
                        return _buildHistoryItem(context, item);
                      },
                    ),
            ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: AppColors.hintTextColor),
          SizedBox(height: AppConstants.paragraphSpacing),
          Text('暂无历史活动或公告', style: AppTextStyles.h2.copyWith(color: AppColors.hintTextColor)),
          SizedBox(height: AppConstants.lineSpacing),
          Text('下拉可以刷新', style: AppTextStyles.caption),
        ],
      ),
    );
  }

  /// 构建历史项
  Widget _buildHistoryItem(BuildContext context, _HistoryItem item) {
    if (item.isActivity) {
      final activity = item.activity!;
      return GestureDetector(
        onTap: () {
          NavigationService.navigateToActivityDetail(context, activity);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: AppConstants.cardSpacing),
          decoration: AppConstants.cardDecoration,
          padding: EdgeInsets.all(AppConstants.pageMargin),
          child: Row(
            children: [
              Icon(Icons.event, color: AppColors.accentColor, size: 32),
              SizedBox(width: AppConstants.paragraphSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(activity.title, style: AppTextStyles.h2),
                    SizedBox(height: 4),
                    Text(activity.summary, style: AppTextStyles.bodySecondary, maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4),
                    Text(activity.formattedCreateTime, style: AppTextStyles.caption),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.hintTextColor),
            ],
          ),
        ),
      );
    } else {
      final notice = item.notice!;
      return GestureDetector(
        onTap: () {
          NavigationService.navigateToNoticeDetail(context, notice);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: AppConstants.cardSpacing),
          decoration: AppConstants.cardDecoration,
          padding: EdgeInsets.all(AppConstants.pageMargin),
          child: Row(
            children: [
              Icon(Icons.campaign, color: AppColors.primaryBlue, size: 32),
              SizedBox(width: AppConstants.paragraphSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notice.title, style: AppTextStyles.h2),
                    SizedBox(height: 4),
                    Text(notice.summary, style: AppTextStyles.bodySecondary, maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4),
                    Text(notice.formattedTime, style: AppTextStyles.caption),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.hintTextColor),
            ],
          ),
        ),
      );
    }
  }
}

/// 历史项类型
class _HistoryItem {
  final Activity? activity;
  final Notice? notice;
  final DateTime time;
  bool get isActivity => activity != null;
  bool get isNotice => notice != null;
  _HistoryItem.activity(Activity a)
      : activity = a,
        notice = null,
        time = a.createTime;
  _HistoryItem.notice(Notice n)
      : activity = null,
        notice = n,
        time = n.createTime;
} 