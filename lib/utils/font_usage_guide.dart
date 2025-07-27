import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// 字体使用指南
/// 
/// 本文件详细说明了项目中各种字体样式的使用场景和最佳实践
/// 按照设计规范定义的字体大小和用途进行组织

class FontUsageGuide {
  
  /// 标题字体使用指南
  static Widget buildTitleUsageGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('标题字体使用指南', style: AppTextStyles.h2),
        SizedBox(height: 16),
        
        // H1 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('H1 - 24px (页面主标题)', style: AppTextStyles.h1),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 页面主标题', style: AppTextStyles.bodySmall),
              Text('• 重要功能入口', style: AppTextStyles.bodySmall),
              Text('• 品牌展示', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：社区投票、智慧物业服务', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // H2 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('H2 - 20px (用户名、区域标题)', style: AppTextStyles.h2),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 用户名显示', style: AppTextStyles.bodySmall),
              Text('• 区域标题', style: AppTextStyles.bodySmall),
              Text('• 功能模块标题', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：DASEIN、我的服务', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // H3 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('H3 - 16px (轮播标题、金额)', style: AppTextStyles.h3),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 轮播图标题', style: AppTextStyles.bodySmall),
              Text('• 金额显示', style: AppTextStyles.bodySmall),
              Text('• 卡片标题', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：智慧物业服务、¥299', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
  
  /// Body字体使用指南
  static Widget buildBodyUsageGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Body字体使用指南', style: AppTextStyles.h2),
        SizedBox(height: 16),
        
        // Body Large 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Body Large - 14px (重要标题、导航)', style: AppTextStyles.bodyLarge),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 重要标题', style: AppTextStyles.bodySmall),
              Text('• 导航菜单', style: AppTextStyles.bodySmall),
              Text('• 按钮文字', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：物业公告、报事报修', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // Body Medium 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Body Medium - 12px (正文、按钮、表单)', style: AppTextStyles.bodyMedium),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 正文内容', style: AppTextStyles.bodySmall),
              Text('• 按钮文字', style: AppTextStyles.bodySmall),
              Text('• 表单输入', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：滇池卫城、立即缴费', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // Body Small 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Body Small - 10px (辅助文字、时间)', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 辅助说明文字', style: AppTextStyles.bodySmall),
              Text('• 时间显示', style: AppTextStyles.bodySmall),
              Text('• 次要信息', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：访问时间、让生活更美好', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
  
  /// 小字体使用指南
  static Widget buildSmallFontUsageGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('小字体使用指南', style: AppTextStyles.h2),
        SizedBox(height: 16),
        
        // Caption 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Caption - 8px (标签、导航、说明)', style: AppTextStyles.caption),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 标签文字', style: AppTextStyles.bodySmall),
              Text('• 导航文字', style: AppTextStyles.bodySmall),
              Text('• 说明文字', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：业主、首页、2025年1月', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // Label 使用示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Label - 6px (角标数字)', style: AppTextStyles.label.copyWith(color: AppColors.primaryTextColor)),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('3', style: AppTextStyles.label),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 角标数字', style: AppTextStyles.bodySmall),
              Text('• 徽章文字', style: AppTextStyles.bodySmall),
              Text('• 极小文字', style: AppTextStyles.bodySmall),
              SizedBox(height: 8),
              Text('示例：消息数量、未读提醒', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
  
  /// 颜色变种使用指南
  static Widget buildColorVariantsGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('颜色变种使用指南', style: AppTextStyles.h2),
        SizedBox(height: 16),
        
        // 强调色示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('强调色文字', style: AppTextStyles.h2White),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMediumWhite),
              Text('• 重要信息', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
              Text('• 选中状态', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
              Text('• 按钮文字', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
              SizedBox(height: 8),
              Text('示例：主要按钮、导航选中', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // 辅助色示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.assistantColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('辅助色文字', style: AppTextStyles.bodyLargeWhite),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMediumWhite),
              Text('• 次要信息', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
              Text('• 边框文字', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
              Text('• 说明文字', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
              SizedBox(height: 8),
              Text('示例：次要按钮、说明文字', style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
            ],
          ),
        ),
        SizedBox(height: 12),
        
        // 状态色示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('状态色文字', style: AppTextStyles.bodyMedium),
              SizedBox(height: 8),
              Text('错误信息', style: AppTextStyles.bodyMediumError),
              Text('成功信息', style: AppTextStyles.bodyMediumSuccess),
              SizedBox(height: 8),
              Text('使用场景：', style: AppTextStyles.bodyMedium),
              Text('• 错误提示', style: AppTextStyles.bodySmall),
              Text('• 成功反馈', style: AppTextStyles.bodySmall),
              Text('• 警告信息', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
  
  /// 实际应用示例
  static Widget buildPracticalExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('实际应用示例', style: AppTextStyles.h2),
        SizedBox(height: 16),
        
        // 卡片示例
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey200),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('物业公告', style: AppTextStyles.h3),
              SizedBox(height: 8),
              Text('关于小区电梯维修的通知', style: AppTextStyles.bodyMedium),
              SizedBox(height: 8),
              Text('为了保障业主安全，将于本周六进行电梯维修...', style: AppTextStyles.bodySmall),
              SizedBox(height: 12),
              Row(
                children: [
                  Text('发布时间：', style: AppTextStyles.caption),
                  Text('2025年1月15日', style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        
        // 按钮示例
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('立即缴费', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.assistantColor,
                  side: BorderSide(color: AppColors.assistantColor),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('查看详情', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.assistantColor)),
              ),
            ),
          ],
        ),
      ],
    );
  }


}

/// 字体使用指南页面
class FontUsageGuidePage extends StatelessWidget {
  const FontUsageGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('字体使用指南', style: AppTextStyles.bodyLarge),
        backgroundColor: AppColors.accentColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FontUsageGuide.buildTitleUsageGuide(),
            SizedBox(height: 32),
            FontUsageGuide.buildBodyUsageGuide(),
            SizedBox(height: 32),
            FontUsageGuide.buildSmallFontUsageGuide(),
            SizedBox(height: 32),
            FontUsageGuide.buildColorVariantsGuide(),
                          SizedBox(height: 32),
              FontUsageGuide.buildPracticalExamples(),
          ],
        ),
      ),
    );
  }
} 