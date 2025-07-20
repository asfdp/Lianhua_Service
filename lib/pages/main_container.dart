import 'package:flutter/material.dart';
import 'home_page.dart';
import 'my_page.dart';

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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