import 'package:flutter/material.dart';
import 'home_page.dart';
import 'my_page.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../constants/app_constants.dart';

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: IndexedStack(
          index: _currentBottomIndex,
          children: [
            HomePage(),
            MyPage(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // 底部导航栏
  Widget _buildBottomNavigationBar() {
    return Container(
      height: AppConstants.bottomNavigationHeight,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.dividerColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: AppConstants.shadowBlurRadius,
            spreadRadius: AppConstants.shadowSpreadRadius,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentBottomIndex = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppConstants.lineSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: _currentBottomIndex == 0 ? AppColors.accentColor : AppColors.hintTextColor,
                      size: AppConstants.mediumIconSize,
                    ),
                    SizedBox(height: AppConstants.lineSpacing / 2),
                    Text(
                      '首页',
                      style: _currentBottomIndex == 0 
                          ? AppTextStyles.caption.copyWith(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w500,
                            )
                          : AppTextStyles.caption.copyWith(
                              color: AppColors.hintTextColor,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 分割线
          Container(
            width: 1,
            height: AppConstants.largeIconSize,
            color: AppColors.dividerColor,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentBottomIndex = 1;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: AppConstants.lineSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: _currentBottomIndex == 1 ? AppColors.accentColor : AppColors.hintTextColor,
                      size: AppConstants.mediumIconSize,
                    ),
                    SizedBox(height: AppConstants.lineSpacing / 2),
                    Text(
                      '我的',
                      style: _currentBottomIndex == 1 
                          ? AppTextStyles.caption.copyWith(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w500,
                            )
                          : AppTextStyles.caption.copyWith(
                              color: AppColors.hintTextColor,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 