import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// 设计系统使用指南
/// 
/// 这个文件展示了如何在项目中使用统一的设计系统
/// 包括颜色、文字样式、按钮样式和间距的正确使用方法

class DesignSystemGuide {
  
  // 间距定义
  static const double pageMargin = 16.0;           // 页面边距：16dp
  static const double moduleSpacing = 24.0;        // 模块间距：24dp
  static const double lineSpacing = 6.0;           // 行间距：6dp
  static const double paragraphSpacing = 12.0;     // 文字段落间距：12dp
  
  // 按钮定义
  static const double buttonRadius = 8.0;          // 按钮圆角：8dp
  static const double buttonHeight = 48.0;         // 按钮高度：48dp
  static const double buttonBorderWidth = 1.0;     // 次要按钮边框：1dp
  
  /// 文字样式使用示例
  static Widget buildTextStyleExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题 - 20sp，页面主标题
        Text('社区投票', style: AppTextStyles.title),
        SizedBox(height: paragraphSpacing),
        
        // 一级标题 - 18sp，重要标题、导航  
        Text('DASEIN', style: AppTextStyles.h1),
        SizedBox(height: paragraphSpacing),
        
        // 二级标题 - 16sp，次级标题
        Text('智慧物业服务', style: AppTextStyles.h2),
        SizedBox(height: paragraphSpacing),
        
        // 正文 - 14sp，正文、按钮、表单
        Text('滇池卫城', style: AppTextStyles.body),
        Text('立即缴费', style: AppTextStyles.body),
        SizedBox(height: lineSpacing),
        
        // 次要文字 - 14sp，使用次要文字颜色
        Text('访问时间', style: AppTextStyles.bodySecondary),
        Text('让生活更美好', style: AppTextStyles.bodySecondary),
        SizedBox(height: lineSpacing),
        
        // 辅助文字 - 12sp，标签、导航、说明
        Text('业主', style: AppTextStyles.caption),
        Text('首页', style: AppTextStyles.caption),
        Text('2025年1月', style: AppTextStyles.caption),
        SizedBox(height: lineSpacing),
        
        // 提示文字 - 12sp，使用提示文字颜色
        Text('请输入内容', style: AppTextStyles.hint),
        SizedBox(height: lineSpacing),
        
        // Label - 10sp，角标数字
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
            child: Text('主色调 #FFF2E3', style: AppTextStyles.body),
          ),
        ),
        SizedBox(height: lineSpacing),
        
        // 辅助色变体1
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.primaryVariant1,
          child: Center(
            child: Text('辅助色变体1 #FAE7D5', style: AppTextStyles.body),
          ),
        ),
        SizedBox(height: lineSpacing),
        
        // 辅助色变体2
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.primaryVariant2,
          child: Center(
            child: Text('辅助色变体2 #F7E9DA', style: AppTextStyles.body),
          ),
        ),
        SizedBox(height: lineSpacing),
        
        // 强调色示例 - 按钮、选中状态、重要文字
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.accentColor,
          child: Center(
            child: Text('强调色 #D4AF9A', style: AppTextStyles.bodyWhite),
          ),
        ),
        SizedBox(height: lineSpacing),
        
        // 辅助色示例 - 次要按钮、边框
        Container(
          width: double.infinity,
          height: 60,
          color: AppColors.assistantColor,
          child: Center(
            child: Text('辅助色 #C19A82', style: AppTextStyles.bodyWhite),
          ),
        ),
        SizedBox(height: lineSpacing),
        
        // 分割线颜色示例
        Container(
          width: double.infinity,
          height: 2,
          color: AppColors.dividerColor,
        ),
        SizedBox(height: lineSpacing),
        Text('分割线颜色 #E0E0E0', style: AppTextStyles.caption),
      ],
    );
  }
  
  /// 带颜色的文字样式示例
  static Widget buildStyledTextExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('强调色标题', style: AppTextStyles.titleAccent),
        Text('强调色正文', style: AppTextStyles.bodyAccent),
        SizedBox(height: lineSpacing),
        
        Text('辅助色标题', style: AppTextStyles.h1Assistant),
        Text('辅助色说明', style: AppTextStyles.captionAssistant),
        SizedBox(height: lineSpacing),
        
        Text('错误信息', style: AppTextStyles.bodyError),
        Text('成功信息', style: AppTextStyles.bodySuccess),
      ],
    );
  }
  
  /// 按钮样式示例（按新规范）
  static Widget buildButtonExamples() {
    return Column(
      children: [
        // 主要按钮 - 主色调/辅助色背景，白色文字，8dp圆角，48dp高度
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentColor,
              foregroundColor: AppColors.primaryButtonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
              elevation: 0,
            ),
            child: Text('主要按钮', style: AppTextStyles.body.copyWith(color: AppColors.primaryButtonText)),
          ),
        ),
        SizedBox(height: paragraphSpacing),
        
        // 次要按钮 - 透明背景，主色调/辅助色文字，1dp边框，8dp圆角，48dp高度
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.secondaryButtonBackground,
              foregroundColor: AppColors.secondaryButtonText,
              side: BorderSide(
                color: AppColors.secondaryButtonBorder, 
                width: buttonBorderWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
            ),
            child: Text('次要按钮', style: AppTextStyles.body.copyWith(color: AppColors.secondaryButtonText)),
          ),
        ),
        SizedBox(height: paragraphSpacing),
        
        // 主色调背景的主要按钮
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.primaryTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
              elevation: 0,
            ),
            child: Text('主色调背景按钮', style: AppTextStyles.body),
          ),
        ),
      ],
    );
  }
  
  /// 卡片样式示例
  static Widget buildCardExample() {
    return Container(
      padding: EdgeInsets.all(pageMargin),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('卡片标题', style: AppTextStyles.h1),
          SizedBox(height: lineSpacing),
          Text('这是卡片内容，使用了主色作为背景色，分割线颜色作为边框。', style: AppTextStyles.body),
          SizedBox(height: paragraphSpacing),
          Text('次要信息', style: AppTextStyles.bodySecondary),
        ],
      ),
    );
  }
  
  /// 间距使用示例
  static Widget buildSpacingExamples() {
    return Container(
      padding: EdgeInsets.all(pageMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('间距使用示例', style: AppTextStyles.title),
          SizedBox(height: moduleSpacing), // 模块间距：24dp
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(pageMargin),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('页面边距：16dp', style: AppTextStyles.h2),
                SizedBox(height: lineSpacing), // 行间距：6dp
                Text('行间距：6dp', style: AppTextStyles.body),
                SizedBox(height: paragraphSpacing), // 文字段落间距：12dp
                Text('文字段落间距：12dp', style: AppTextStyles.body),
              ],
            ),
          ),
          
          SizedBox(height: moduleSpacing), // 模块间距：24dp
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(pageMargin),
            decoration: BoxDecoration(
              color: AppColors.primaryVariant1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('模块间距：24dp', style: AppTextStyles.h2),
          ),
        ],
      ),
    );
  }
}

/// 使用示例页面
class DesignSystemExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('设计系统示例', style: AppTextStyles.h1White),
        backgroundColor: AppColors.accentColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DesignSystemGuide.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('文字样式示例', style: AppTextStyles.title),
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            DesignSystemGuide.buildTextStyleExamples(),
            
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            Text('颜色使用示例', style: AppTextStyles.title),
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            DesignSystemGuide.buildColorExamples(),
            
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            Text('带颜色的文字样式', style: AppTextStyles.title),
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            DesignSystemGuide.buildStyledTextExamples(),
            
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            Text('按钮样式示例', style: AppTextStyles.title),
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            DesignSystemGuide.buildButtonExamples(),
            
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            Text('卡片样式示例', style: AppTextStyles.title),
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            DesignSystemGuide.buildCardExample(),
            
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            Text('间距使用示例', style: AppTextStyles.title),
            SizedBox(height: DesignSystemGuide.moduleSpacing),
            DesignSystemGuide.buildSpacingExamples(),
          ],
        ),
      ),
    );
  }
} 