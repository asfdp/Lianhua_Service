import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 头部用户信息区域
            _buildHeaderSection(),
            
            // 功能图标区域
            _buildFunctionGrid(),
            
            // 设置/法律链接列表
            _buildSettingsList(),
            
            // 退出登录按钮
            _buildLogoutButton(),
            
            SizedBox(height: AppConstants.moduleSpacing),
          ],
        ),
      ),
    );
  }

  // 头部用户信息区域
  Widget _buildHeaderSection() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accentColor,
            AppColors.assistantColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          // 波浪状背景图案
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              painter: WavePainter(),
            ),
          ),
          
          // 用户信息内容
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppConstants.pageMargin, 
                AppConstants.sectionSpacing, 
                AppConstants.pageMargin, 
                AppConstants.pageMargin,
              ),
              child: Row(
                children: [
                  // 用户头像
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: AppConstants.shadowBlurRadius,
                              spreadRadius: AppConstants.shadowSpreadRadius,
                              offset: AppConstants.shadowOffset,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'images/splash_logo.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.accentColor,
                                  size: AppConstants.extraLargeIconSize,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // 业主标签
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.lineSpacing,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            '业主',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(width: AppConstants.pageMargin),
                  
                  // 用户信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'DASEIN',
                          style: AppTextStyles.title.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppConstants.lineSpacing),
                        GestureDetector(
                          onTap: () {
                            // 编辑资料功能
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.family_restroom,
                                color: Colors.white.withOpacity(0.9),
                                size: AppConstants.smallIconSize,
                              ),
                              SizedBox(width: AppConstants.lineSpacing / 2),
                              Text(
                                '家庭成员3人',
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(width: AppConstants.lineSpacing / 2),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white.withOpacity(0.7),
                                size: AppConstants.smallIconSize,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 编辑资料按钮
                  GestureDetector(
                    onTap: () {
                      // 编辑资料功能
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.paragraphSpacing,
                        vertical: AppConstants.lineSpacing,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppConstants.largeRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: AppConstants.smallIconSize,
                          ),
                          SizedBox(width: AppConstants.lineSpacing / 2),
                          Text(
                            '编辑资料',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 功能图标网格
  Widget _buildFunctionGrid() {
    final functions = [
      {'icon': Icons.family_restroom_outlined, 'title': '家庭成员'},
      {'icon': Icons.directions_car_outlined, 'title': '家庭用车'},
      {'icon': Icons.people_outline, 'title': '我的访客'},
      {'icon': Icons.home_outlined, 'title': '我的房产'},
      {'icon': Icons.payment_outlined, 'title': '临停缴费'},
      {'icon': Icons.assignment_outlined, 'title': '工单跟踪'},
      {'icon': Icons.question_answer_outlined, 'title': '问卷历史'},
    ];

    return Container(
      margin: EdgeInsets.all(AppConstants.pageMargin),
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: AppConstants.cardDecoration,
      child: Column(
        children: [
          // 第一行
          Row(
            children: functions.take(4).map((function) => Expanded(
              child: _buildFunctionItem(function['icon'] as IconData, function['title'] as String),
            )).toList(),
          ),
          SizedBox(height: AppConstants.sectionSpacing),
          // 第二行
          Row(
            children: functions.skip(4).map((function) => Expanded(
              child: _buildFunctionItem(function['icon'] as IconData, function['title'] as String),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // 单个功能项
  Widget _buildFunctionItem(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        // 功能点击处理
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.lineSpacing,
          vertical: AppConstants.paragraphSpacing,
        ),
        child: Column(
          children: [
            Container(
              width: AppConstants.menuIconSize,
              height: AppConstants.menuIconSize,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentColor.withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: AppConstants.mediumIconSize,
              ),
            ),
            SizedBox(height: AppConstants.lineSpacing),
            Text(
              title,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 设置/法律链接列表
  Widget _buildSettingsList() {
    final settings = [
      {'title': '用户协议', 'icon': Icons.description_outlined},
      {'title': '隐私政策', 'icon': Icons.privacy_tip_outlined},
      {'title': '当前版本', 'icon': Icons.info_outline, 'subtitle': AppConstants.appVersion},
      {'title': '注销账号', 'icon': Icons.delete_forever_outlined},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.pageMargin),
      decoration: AppConstants.cardDecoration,
      child: Column(
        children: settings.asMap().entries.map((entry) {
          final index = entry.key;
          final setting = entry.value;
          final isLast = index == settings.length - 1;
          
          return _buildSettingItem(
            setting['icon'] as IconData,
            setting['title'] as String,
            setting['subtitle'] as String?,
            isLast,
          );
        }).toList(),
      ),
    );
  }

  // 单个设置项
  Widget _buildSettingItem(IconData icon, String title, String? subtitle, bool isLast) {
    return GestureDetector(
      onTap: () {
        // 设置项点击处理
      },
      child: Container(
        padding: EdgeInsets.all(AppConstants.pageMargin),
        decoration: BoxDecoration(
          border: isLast ? null : Border(
            bottom: BorderSide(color: AppColors.dividerColor, width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.accentColor,
              size: AppConstants.mediumIconSize,
            ),
            SizedBox(width: AppConstants.pageMargin),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppConstants.lineSpacing / 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.hintTextColor,
              size: AppConstants.smallIconSize,
            ),
          ],
        ),
      ),
    );
  }

  // 退出登录按钮
  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.all(AppConstants.pageMargin),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // 退出登录功能
        },
        style: AppConstants.secondaryButtonStyle,
        child: Text(
          '退出登录',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// 波浪状背景绘制器
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    
    // 绘制波浪
    for (double i = 0; i < size.width; i += 30) {
      path.quadraticBezierTo(
        i + 15, size.height * 0.7,
        i + 30, size.height * 0.8,
      );
    }
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 