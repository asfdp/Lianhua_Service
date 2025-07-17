import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '社区服务',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _currentBottomIndex = 0;
  Timer? _bannerTimer;

  // 轮播图数据
  final List<String> _bannerImages = [
    'images/building.png',
    'images/skyline.png',
    'images/sea.png',
  ];

  // 功能菜单数据
  final List<Map<String, dynamic>> _menuItems = [
    {'title': '投票报修', 'color': Colors.orange[200]},
    {'title': '物业收费', 'color': Colors.yellow[200]},
    {'title': '访客登记', 'color': Colors.brown[200]},
    {'title': '车辆管理', 'color': Colors.orange[300]},
    {'title': '便民信息', 'color': Colors.blue[200]},
    {'title': '投诉建议', 'color': Colors.orange[200]},
    {'title': '问卷调查', 'color': Colors.green[200]},
    {'title': '住户投票', 'color': Colors.yellow[300]},
    {'title': '装修申请', 'color': Colors.orange[200]},
    {'title': '物品放行', 'color': Colors.orange[200]},
  ];

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: _currentBottomIndex == 0 ? _buildHomePage() : _buildMyPage(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // 启动轮播图计时器
  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(Duration(milliseconds: 3000), (timer) {
      if (_currentIndex < _bannerImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  // 暂停轮播图计时器
  void _pauseBannerTimer() {
    _bannerTimer?.cancel();
  }

  // 恢复轮播图计时器
  void _resumeBannerTimer() {
    _pauseBannerTimer();
    _startBannerTimer();
  }

  // 延迟恢复轮播图计时器
  void _delayedResumeBannerTimer() {
    _pauseBannerTimer();
    Timer(Duration(milliseconds: 1000), () {
      if (_currentBottomIndex == 0) {
        _startBannerTimer();
      }
    });
  }

  // 首页内容
  Widget _buildHomePage() {
    return Column(
      children: [
        // 顶部导航栏
        _buildTopBar(),
        
        // 轮播图
        _buildBannerSection(),
        
        // 功能菜单
        _buildMenuSection(),
        
        // 底部消息提醒
        _buildNotificationSection(),
      ],
    );
  }

  // 我的页面
  Widget _buildMyPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
        // 顶部导航栏
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white,
          child: Row(
            children: [
              Text(
                '我的',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.settings, color: Colors.grey),
            ],
          ),
        ),
        
        // 个人信息区域
        Container(
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
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.person, size: 40, color: Colors.blue),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '用户名',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '滇池卫城业主',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // 功能列表
        Container(
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
                         children: [
               _buildMyPageItem(Icons.payment, '我的缴费', '查看缴费记录', false),
               _buildMyPageItem(Icons.build, '我的报修', '查看报修记录', false),
               _buildMyPageItem(Icons.directions_car, '我的车辆', '车辆信息管理', false),
               _buildMyPageItem(Icons.message, '我的消息', '查看所有消息', false),
               _buildMyPageItem(Icons.help, '帮助中心', '常见问题解答', true),
             ],
          ),
        ),
      ],
      ),
    );
  }

  // 我的页面单个项目
  Widget _buildMyPageItem(IconData icon, String title, String subtitle, bool isLast) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title功能待开发')),
        );
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
            Icon(icon, color: Colors.blue, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  // 顶部导航栏
  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue, size: 20),
          SizedBox(width: 8),
          Text(
            '滇池卫城',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          Spacer(),
          Icon(Icons.search, color: Colors.grey),
        ],
      ),
    );
  }

  // 轮播图区域
  Widget _buildBannerSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: 150,
      child: Stack(
        children: [
          // 轮播图
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onPanDown: (details) {
                _pauseBannerTimer();
              },
              onPanEnd: (details) {
                _delayedResumeBannerTimer();
              },
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _bannerImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      _bannerImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Colors.blue[300]!, Colors.blue[100]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '图片加载失败',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          
          // 指示器
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_bannerImages.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // 功能菜单区域
  Widget _buildMenuSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: EdgeInsets.all(12),
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
          // 第一行 - 4个功能
          Row(
            children: _menuItems.take(4).map((item) => 
              Expanded(child: _buildMenuItem(item))
            ).toList(),
          ),
          SizedBox(height: 12),
          
          // 第二行 - 4个功能
          Row(
            children: _menuItems.skip(4).take(4).map((item) => 
              Expanded(child: _buildMenuItem(item))
            ).toList(),
          ),
          SizedBox(height: 12),
          
          // 第三行 - 2个功能
          Row(
            children: [
              Expanded(child: _buildMenuItem(_menuItems[8])),
              Expanded(child: _buildMenuItem(_menuItems[9])),
              Expanded(child: SizedBox()),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  // 单个菜单项
  Widget _buildMenuItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('点击了${item['title']}')),
        );
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item['color'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForTitle(item['title']),
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(height: 6),
          Text(
            item['title'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // 根据标题获取图标
  IconData _getIconForTitle(String title) {
    switch (title) {
      case '投票报修':
        return Icons.build;
      case '物业收费':
        return Icons.payment;
      case '访客登记':
        return Icons.people;
      case '车辆管理':
        return Icons.directions_car;
      case '便民信息':
        return Icons.info;
      case '投诉建议':
        return Icons.feedback;
      case '问卷调查':
        return Icons.assignment;
      case '住户投票':
        return Icons.how_to_vote;
      case '装修申请':
        return Icons.construction;
      case '物品放行':
        return Icons.local_shipping;
      default:
        return Icons.apps;
    }
  }

  // 底部消息提醒区域
  Widget _buildNotificationSection() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
        padding: EdgeInsets.all(12),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                                 Text(
                   '物业公告',
                   style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.bold,
                     color: Colors.grey[800],
                   ),
                 ),
                Spacer(),
                                 Text(
                   '更多消息未读',
                   style: TextStyle(
                     fontSize: 10,
                     color: Colors.grey[500],
                   ),
                 ),
                                 Container(
                   margin: EdgeInsets.only(left: 4),
                   padding: EdgeInsets.all(2),
                   decoration: BoxDecoration(
                     color: Colors.red,
                     shape: BoxShape.circle,
                   ),
                   child: Text(
                     '3',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 8,
                     ),
                   ),
                 ),
              ],
            ),
            SizedBox(height: 8),
            
            // 消息列表
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNotificationItem(
                      '缴费提醒',
                      '2023年7月物业管理费缴费提醒',
                      '4小时前',
                    ),
                    _buildNotificationItem(
                      '保洁工作通知',
                      '7月保洁时间日程安排',
                      '7月10日',
                    ),
                    _buildNotificationItem(
                      '服务升级',
                      '2023年6月滇池卫城物业服务升级',
                      '6月28日',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 单个通知项
  Widget _buildNotificationItem(String title, String content, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
                     Container(
             width: 6,
             height: 6,
             decoration: BoxDecoration(
               color: Colors.orange,
               shape: BoxShape.circle,
             ),
           ),
           SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                                 Text(
                   title,
                   style: TextStyle(
                     fontSize: 12,
                     fontWeight: FontWeight.w500,
                     color: Colors.grey[800],
                   ),
                                 ),
                SizedBox(height: 1),
                Text(
                   content,
                   style: TextStyle(
                     fontSize: 10,
                     color: Colors.grey[600],
                   ),
                 ),
              ],
            ),
          ),
                     Text(
             time,
             style: TextStyle(
               fontSize: 10,
               color: Colors.grey[500],
             ),
           ),
        ],
      ),
    );
  }

  // 底部导航栏
  Widget _buildBottomNavigationBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentBottomIndex = 0;
                });
                _resumeBannerTimer();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: _currentBottomIndex == 0 ? Colors.blue : Colors.grey[600],
                    size: 24,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '首页',
                    style: TextStyle(
                      fontSize: 12,
                      color: _currentBottomIndex == 0 ? Colors.blue : Colors.grey[600],
                      fontWeight: _currentBottomIndex == 0 ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentBottomIndex = 1;
                });
                _pauseBannerTimer();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: _currentBottomIndex == 1 ? Colors.blue : Colors.grey[600],
                    size: 24,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '我的',
                    style: TextStyle(
                      fontSize: 12,
                      color: _currentBottomIndex == 1 ? Colors.blue : Colors.grey[600],
                      fontWeight: _currentBottomIndex == 1 ? FontWeight.w500 : FontWeight.normal,
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
}
