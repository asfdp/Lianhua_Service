import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final Color? color;
  final IconData? icon;
  final VoidCallback? onTap;

  MenuItem({
    required this.title,
    this.color,
    this.icon,
    this.onTap,
  });
}

class MenuGridWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final int crossAxisCount;
  final double? itemHeight;

  const MenuGridWidget({
    Key? key,
    required this.menuItems,
    this.crossAxisCount = 4,
    this.itemHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        children: _buildRows(),
      ),
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
      if (i + crossAxisCount < menuItems.length) {
        rows.add(SizedBox(height: 12));
      }
    }
    
    return rows;
  }

  Widget _buildMenuItem(MenuItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item.color ?? Colors.blue[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon ?? _getIconForTitle(item.title),
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(height: 6),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // 根据标题获取默认图标
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
} 