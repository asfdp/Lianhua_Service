class AppConstants {
  // 应用信息
  static const String appTitle = '莲花物业';
  static const String communityName = '滇池卫城';
  static const String userTitle = '滇池卫城业主';
  
  // 轮播图图片
  static const List<String> bannerImages = [
    'images/building.png',
    'images/skyline.png',
    'images/sea.png',
  ];
  
  // 功能菜单数据
  static const List<Map<String, String>> menuTitles = [
    {'title': '投票报修'},
    {'title': '物业收费'},
    {'title': '访客登记'},
    {'title': '车辆管理'},
    {'title': '便民信息'},
    {'title': '投诉建议'},
    {'title': '问卷调查'},
    {'title': '住户投票'},
    {'title': '装修申请'},
    {'title': '物品放行'},
  ];
  
  // 我的页面功能
  static const List<Map<String, String>> myPageItems = [
    {'title': '我的缴费', 'subtitle': '查看缴费记录'},
    {'title': '我的报修', 'subtitle': '查看报修记录'},
    {'title': '我的车辆', 'subtitle': '车辆信息管理'},
    {'title': '我的消息', 'subtitle': '查看所有消息'},
    {'title': '帮助中心', 'subtitle': '常见问题解答'},
  ];
  
  // 时间设置
  static const Duration bannerAutoPlayDuration = Duration(milliseconds: 3000);
  static const Duration bannerAnimationDuration = Duration(milliseconds: 700);
  static const Duration bannerResumeDelay = Duration(milliseconds: 1000);
  
  // 尺寸设置
  static const double bannerHeight = 150.0;
  static const double bottomNavigationHeight = 60.0;
  static const double menuIconSize = 50.0;
  static const double borderRadius = 12.0;
} 