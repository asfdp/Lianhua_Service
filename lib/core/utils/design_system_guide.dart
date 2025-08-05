import 'package:flutter/material.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';

/// 设计系统使用指南
/// 
/// 这个文件展示了如何在项目中使用统一的设计系统
/// 包括颜色和文字样式的正确使用方法

class DesignSystemGuide {
  
  /// 文字样式使用示例
  static Widget buildTextStyleExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // H1 大标题 - 28px，页面主标题
        Text('社区投票', style: AppTextStyles.h1),
        SizedBox(height: 16),
        
        // H2 中标题 - 24px，用户名、区域标题  
        Text('DASEIN', style: AppTextStyles.h2),
        SizedBox(height: 12),
        
        // H3 小标题 - 20px，轮播标题、金额
        Text('智慧物业服务', style: AppTextStyles.h3),
        SizedBox(height: 12),
        
        // Body Large - 18px，重要标题、导航
        Text('物业公告', style: AppTextStyles.bodyLarge),
        Text('报事报修', style: AppTextStyles.bodyLarge),
        SizedBox(height: 10),
        
        // Body Medium - 16px，正文、按钮、表单
        Text('滇池卫城', style: AppTextStyles.bodyMedium),
        Text('立即缴费', style: AppTextStyles.bodyMedium),
        SizedBox(height: 10),
        
        // Body Small - 14px，辅助文字、时间
        Text('访问时间', style: AppTextStyles.bodySmall),
        Text('让生活更美好', style: AppTextStyles.bodySmall),
        SizedBox(height: 8),
        
        // Caption - 12px，标签、导航、说明
        Text('业主', style: AppTextStyles.caption),
        Text('首页', style: AppTextStyles.caption),
        Text('2025年1月', style: AppTextStyles.caption),
        SizedBox(height: 8),
        
        // Label - 10px，角标数字
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('3', style: AppTextStyles.label),
        ),
      ],
    );
  }
  
  /// 颜色使用示例
  static Widget buildColorExamples() {
    return Column(
      children: [
        // 主色示例 - 主要图标、卡片背景
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.primaryColor,
          child: Center(
            child: Text('主色 #FFF2E3', style: AppTextStyles.bodyMedium),
          ),
        ),
        SizedBox(height: 8),
        
        // 强调色示例 - 按钮、选中状态、重要文字
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.accentColor,
          child: Center(
            child: Text('强调色 #D4AF9A', style: AppTextStyles.bodyMediumWhite),
          ),
        ),
        SizedBox(height: 8),
        
        // 辅助色示例 - 次要按钮、边框
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.assistantColor,
          child: Center(
            child: Text('辅助色 #C19A82', style: AppTextStyles.bodyMediumWhite),
          ),
        ),
      ],
    );
  }
  
  /// 带颜色的文字样式示例
  static Widget buildStyledTextExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('强调色标题', style: AppTextStyles.h2Accent),
        Text('强调色正文', style: AppTextStyles.bodyMediumAccent),
        SizedBox(height: 8),
        
        Text('辅助色标题', style: AppTextStyles.bodyLargeAssistant),
        Text('辅助色说明', style: AppTextStyles.captionAssistant),
        SizedBox(height: 8),
        
        Text('错误信息', style: AppTextStyles.bodyMediumError),
        Text('成功信息', style: AppTextStyles.bodyMediumSuccess),
      ],
    );
  }
  
  /// 按钮样式示例
  static Widget buildButtonExamples() {
    return Column(
      children: [
        // 主要按钮
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('主要按钮', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
        ),
        SizedBox(height: 8),
        
        // 次要按钮
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.assistantColor,
            side: BorderSide(color: AppColors.assistantColor),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('次要按钮', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.assistantColor)),
        ),
      ],
    );
  }
  
  /// 卡片样式示例
  static Widget buildCardExample() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.assistantColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('卡片标题', style: AppTextStyles.h3),
          SizedBox(height: 8),
          Text('这是卡片内容，使用了主色作为背景色，辅助色作为边框。', style: AppTextStyles.bodyMedium),
          SizedBox(height: 12),
          Text('次要信息', style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
  
  /// 字体大小对比示例
  static Widget buildFontSizeComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('字体大小对比', style: AppTextStyles.h2),
        SizedBox(height: 16),
        
        // 标题系列
        Text('H1 - 28px (页面主标题)', style: AppTextStyles.h1),
        SizedBox(height: 8),
        Text('H2 - 24px (用户名、区域标题)', style: AppTextStyles.h2),
        SizedBox(height: 8),
        Text('H3 - 20px (轮播标题、金额)', style: AppTextStyles.h3),
        SizedBox(height: 16),
        
        // Body系列
        Text('Body Large - 18px (重要标题、导航)', style: AppTextStyles.bodyLarge),
        SizedBox(height: 8),
        Text('Body Medium - 16px (正文、按钮、表单)', style: AppTextStyles.bodyMedium),
        SizedBox(height: 8),
        Text('Body Small - 14px (辅助文字、时间)', style: AppTextStyles.bodySmall),
        SizedBox(height: 16),
        
        // 小字体系列
        Text('Caption - 12px (标签、导航、说明)', style: AppTextStyles.caption),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('Label - 10px (角标数字)', style: AppTextStyles.label),
        ),
      ],
    );
  }
}

/// 使用示例页面
class DesignSystemExamplePage extends StatelessWidget {
  const DesignSystemExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('设计系统示例', style: AppTextStyles.bodyLarge),
        backgroundColor: AppColors.accentColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('字体大小对比', style: AppTextStyles.h2),
            SizedBox(height: 16),
            DesignSystemGuide.buildFontSizeComparison(),
            
            SizedBox(height: 32),
            Text('文字样式示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            DesignSystemGuide.buildTextStyleExamples(),
            
            SizedBox(height: 32),
            Text('颜色使用示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            DesignSystemGuide.buildColorExamples(),
            
            SizedBox(height: 32),
            Text('带颜色的文字样式', style: AppTextStyles.h2),
            SizedBox(height: 16),
            DesignSystemGuide.buildStyledTextExamples(),
            
            SizedBox(height: 32),
            Text('按钮样式示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            DesignSystemGuide.buildButtonExamples(),
            
            SizedBox(height: 32),
            Text('卡片样式示例', style: AppTextStyles.h2),
            SizedBox(height: 16),
            DesignSystemGuide.buildCardExample(),
          ],
        ),
      ),
    );
  }
} 
