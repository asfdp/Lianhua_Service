import 'package:flutter/material.dart';

/// 节日类型枚举
enum FestivalType {
  normal,        // 平常
  springFestival, // 春节 
  qingming,      // 清明节
  laborDay,      // 劳动节
  dragonBoat,    // 端午节
  midAutumn,     // 中秋节
  nationalDay,   // 国庆节
  christmas,     // 圣诞节
  newYear,       // 元旦
}

/// 节日主题管理器
class FestivalThemeManager {
  
  /// 获取当前应该使用的节日类型
  static FestivalType getCurrentFestival() {
    final now = DateTime.now();
    final month = now.month;
    final day = now.day;
    
    //  元旦 (1月1-3日)
    if (month == 1 && day <= 3) {
      return FestivalType.newYear;
    }
    
    //  春节 (基于农历，这里暂定为2月份)
    if (month == 2 && day >= 10 && day <= 17) {
      return FestivalType.springFestival;
    }
    
    //  清明节 (4月4-6日)
    if (month == 4 && day >= 4 && day <= 6) {
      return FestivalType.qingming;
    }
    
    //  劳动节 (5月1-3日)
    if (month == 5 && day >= 1 && day <= 3) {
      return FestivalType.laborDay;
    }
    
    //  端午节 (农历五月初五，阳历大约6月20-25日)
    if (month == 6 && day >= 20 && day <= 25) {
      return FestivalType.dragonBoat;
    }
    
    //  中秋节 (农历八月十五，阳历大约9月15-20日)
    if (month == 9 && day >= 15 && day <= 20) {
      return FestivalType.midAutumn;
    }
    
    //  国庆节 (10月1-7日)
    if (month == 10 && day >= 1 && day <= 7) {
      return FestivalType.nationalDay;
    }
    
    //  圣诞节 (12月24-26日)
    if (month == 12 && day >= 24 && day <= 26) {
      return FestivalType.christmas;
    }
    
    return FestivalType.normal;
  }
  
  /// 根据节日类型获取对应主题
  static ThemeData getThemeByFestival(FestivalType festival) {
    switch (festival) {
      case FestivalType.newYear:
        return _getNewYearTheme();
      case FestivalType.springFestival:
        return _getSpringFestivalTheme();
      case FestivalType.qingming:
        return _getQingmingTheme();
      case FestivalType.laborDay:
        return _getLaborDayTheme();
      case FestivalType.dragonBoat:
        return _getDragonBoatTheme();
      case FestivalType.midAutumn:
        return _getMidAutumnTheme();
      case FestivalType.nationalDay:
        return _getNationalDayTheme();
      case FestivalType.christmas:
        return _getChristmasTheme();
      default:
        return _getNormalTheme();
    }
  }
  
  ///  圣诞节主题 - 红绿配色
  static ThemeData _getChristmasTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Color(0xFFF5F5DC), // 米色背景
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
        accentColor: Colors.green,
        backgroundColor: Color(0xFFF5F5DC),
      ).copyWith(
        secondary: Colors.green,
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        shadowColor: Colors.green.withOpacity(0.3),
      ),
    );
  }
  
  ///  元旦主题 - 金色奢华
  static ThemeData _getNewYearTheme() {
    return ThemeData(
      primarySwatch: Colors.amber,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
      colorScheme: ColorScheme.dark(
        primary: Colors.amber,
        secondary: Colors.yellow,
        background: Color(0xFF1A1A2E),
        surface: Color(0xFF16213E),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.black,
      ),
    );
  }
  
  ///  清明节主题 - 青绿自然
  static ThemeData _getQingmingTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Color(0xFFF0F8F0),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,
        backgroundColor: Color(0xFFF0F8F0),
      ).copyWith(
        secondary: Colors.lightGreen[600],
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        shadowColor: Colors.green.withOpacity(0.2),
      ),
    );
  }
  
  ///  劳动节主题 - 工业蓝灰
  static ThemeData _getLaborDayTheme() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Color(0xFFF5F7FA),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        backgroundColor: Color(0xFFF5F7FA),
      ).copyWith(
        secondary: Colors.blueGrey[600],
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo[700],
        foregroundColor: Colors.white,
      ),
    );
  }
  
  ///  端午节主题 - 竹绿青色
  static ThemeData _getDragonBoatTheme() {
    return ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Color(0xFFF0FFF0),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
        backgroundColor: Color(0xFFF0FFF0),
      ).copyWith(
        secondary: Colors.cyan[600],
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        shadowColor: Colors.teal.withOpacity(0.3),
      ),
    );
  }
  
  ///  中秋节主题 - 金桂橙色
  static ThemeData _getMidAutumnTheme() {
    return ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Color(0xFFFFF8DC),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
        backgroundColor: Color(0xFFFFF8DC),
      ).copyWith(
        secondary: Colors.deepOrange[400],
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        shadowColor: Colors.orange.withOpacity(0.3),
      ),
    );
  }
  
  ///  国庆节主题 - 红色中国风
  static ThemeData _getNationalDayTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Color(0xFFFFFDF0),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
        backgroundColor: Color(0xFFFFFDF0),
      ).copyWith(
        secondary: Colors.yellow[700],
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
      ),
    );
  }
  
  ///  春节主题 - 中国红金色
  static ThemeData _getSpringFestivalTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Color(0xFFFFF8DC),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
        backgroundColor: Color(0xFFFFF8DC),
      ).copyWith(
        secondary: Colors.amber[700],
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red[800],
        foregroundColor: Colors.white,
      ),
    );
  }
  
  ///  平常主题 - 橙色主题
  static ThemeData _getNormalTheme() {
    return ThemeData(
      primarySwatch: MaterialColor(0xFFF19139, {
        50: Color(0x4DF19139),
        100: Color(0x4DF19139),
        200: Color(0x4DF19139),
        300: Color(0x4DF19139),
        400: Color(0x4DF19139),
        500: Color(0x4DF19139),
        600: Color(0x4DF19139),
        700: Color(0x4DF19139),
        800: Color(0x4DF19139),
        900: Color(0x4DF19139),
      }),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(0xFFF19139, {
          50: Color(0x4DF19139),
          100: Color(0x4DF19139),
          200: Color(0x4DF19139),
          300: Color(0x4DF19139),
          400: Color(0x4DF19139),
          500: Color(0x4DF19139),
          600: Color(0x4DF19139),
          700: Color(0x4DF19139),
          800: Color(0x4DF19139),
          900: Color(0x4DF19139),
        }),
        backgroundColor: Color(0xFFF5F5F5),
      ),
    );
  }
  
  /// 获取节日名称
  static String getFestivalName(FestivalType festival) {
    switch (festival) {
      case FestivalType.newYear:
        return ' 元旦快乐';
      case FestivalType.springFestival:
        return ' 春节快乐';
      case FestivalType.qingming:
        return ' 清明节';
      case FestivalType.laborDay:
        return ' 劳动节';
      case FestivalType.dragonBoat:
        return ' 端午节';
      case FestivalType.midAutumn:
        return ' 中秋节';
      case FestivalType.nationalDay:
        return ' 国庆节';
      case FestivalType.christmas:
        return ' 圣诞节';
      default:
        return ' 日常模式';
    }
  }
  
  /// 获取节日问候语
  static String getFestivalGreeting(FestivalType festival) {
    switch (festival) {
      case FestivalType.newYear:
        return '元旦快乐，万事如意！';
      case FestivalType.springFestival:
        return '恭喜发财，红包拿来！';
      case FestivalType.qingming:
        return '踏青思故，慎终追远！';
      case FestivalType.laborDay:
        return '劳动最光荣，致敬每一位劳动者！';
      case FestivalType.dragonBoat:
        return '粽叶飘香，龙舟竞渡！';
      case FestivalType.midAutumn:
        return '花好月圆，阖家团聚！';
      case FestivalType.nationalDay:
        return '祖国繁荣昌盛，人民幸福安康！';
      case FestivalType.christmas:
        return 'Merry Christmas! ';
      default:
        return '欢迎使用社区服务！';
    }
  }
} 