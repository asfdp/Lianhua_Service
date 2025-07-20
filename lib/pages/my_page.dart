import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 头部用户信息区域
  Widget _buildHeaderSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A90E2), // 深蓝色
            Color(0xFF357ABD), // 稍深的蓝色
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
          Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Row(
              children: [
                // 用户头像
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage('images/splash_logo.png'),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                    ),
                    // 业主标签
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '业主',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(width: 16),
                
                // 用户信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DASEIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          // 编辑资料功能
                        },
                        child: Row(
                          children: [
                            Text(
                              '家庭成员3人 >',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '编辑资料',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 功能图标网格
  Widget _buildFunctionGrid() {
    final functions = [
      {'icon': Icons.family_restroom, 'title': '家庭成员'},
      {'icon': Icons.directions_car, 'title': '家庭用车'},
      {'icon': Icons.people, 'title': '我的访客'},
      {'icon': Icons.home, 'title': '我的房产'},
      {'icon': Icons.payment, 'title': '临停缴费'},
      {'icon': Icons.assignment, 'title': '工单跟踪'},
      {'icon': Icons.question_answer, 'title': '问卷历史'},
    ];

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
        children: [
          // 第一行
          Row(
            children: functions.take(4).map((function) => Expanded(
              child: _buildFunctionItem(function['icon'] as IconData, function['title'] as String),
            )).toList(),
          ),
          SizedBox(height: 20),
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
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 设置/法律链接列表
  Widget _buildSettingsList() {
    final settings = [
      {'title': '用户协议', 'icon': Icons.description},
      {'title': '隐私政策', 'icon': Icons.privacy_tip},
      {'title': '当前版本', 'icon': Icons.info, 'subtitle': 'v1.0.0'},
      {'title': '注销账号', 'icon': Icons.delete_forever},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: isLast ? null : Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600], size: 20),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  // 退出登录按钮
  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // 退出登录功能
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue200,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          '退出登录',
          style: TextStyle(
            fontSize: 16,
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