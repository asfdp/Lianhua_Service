import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class MenuItem {
  final String title;
  final Color? color;
  final IconData? icon;
  final VoidCallback? onTap;

  MenuItem({required this.title, this.color, this.icon, this.onTap});
}

class MenuGridWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final int crossAxisCount;
  final double? itemHeight;

  const MenuGridWidget({
    super.key,
    required this.menuItems,
    this.crossAxisCount = 4,
    this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: AppConstants.cardDecoration,
      child: Column(children: _buildRows()),
    );
  }

  List<Widget> _buildRows() {
    List<Widget> rows = [];

    for (int i = 0; i < menuItems.length; i += crossAxisCount) {
      List<Widget> rowItems = [];

      for (int j = 0; j < crossAxisCount; j++) {
        if (i + j < menuItems.length) {
          rowItems.add(Expanded(child: _buildMenuItem(menuItems[i + j])));
        } else {
          rowItems.add(Expanded(child: SizedBox()));
        }
      }

      rows.add(Row(children: rowItems));

      // 添加间距，除了最后一行
      // if (i + crossAxisCount < menuItems.length) {
      //   rows.add(SizedBox(height: AppConstants.sectionSpacing));
      // }
    }

    return rows;
  }

  //主要图标样式
  Widget _buildMenuItem(MenuItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.lineSpacing,
          vertical: AppConstants.lineSpacing,
        ),
        child: Column(
          children: [
            Container(
              width: AppConstants.menuIconSize,
              height: AppConstants.menuIconSize,
              decoration: BoxDecoration(
                color: item.color ?? AppColors.accentColor,
                borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                boxShadow: [
                  BoxShadow(
                    color: (item.color ?? AppColors.accentColor).withValues(
                      alpha: 0.3,
                    ),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                item.icon ?? _getIconForTitle(item.title),
                color: Colors.white,
                size: AppConstants.mediumIconSize,
              ),
            ),
            SizedBox(height: AppConstants.lineSpacing),
            Text(
              item.title,
              // style: AppTextStyles.caption.copyWith(
              //   color: AppColors.primaryTextColor,
              //   fontWeight: FontWeight.w500,
              // ),
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 根据标题获取默认图标
  IconData _getIconForTitle(String title) {
    switch (title) {
      case '投票报修':
        return Icons.build_outlined;
      case '物业收费':
        return Icons.payment_outlined;
      case '访客登记':
        return Icons.people_outline;
      case '车辆管理':
        return Icons.directions_car_outlined;
      case '便民信息':
        return Icons.info_outline;
      case '投诉建议':
        return Icons.feedback_outlined;
      case '问卷调查':
        return Icons.assignment_outlined;
      case '住户投票':
        return Icons.how_to_vote_outlined;
      case '装修申请':
        return Icons.construction_outlined;
      case '物品放行':
        return Icons.local_shipping_outlined;
      default:
        return Icons.apps_outlined;
    }
  }
}
