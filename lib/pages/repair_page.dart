import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_bar_config.dart';

class RepairPage extends StatefulWidget {
  const RepairPage({super.key});

  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = '水电问题';

  final List<String> _categories = [
    '水电问题',
    '门窗维修',
    '空调问题',
    '网络问题',
    '其他问题',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarConfig.accentAppBar(
        title: '报事报修',
        actions: [
          AppBarConfig.notificationAction(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('查看历史报修记录')),
              );
            },
            badgeCount: 2,
          ),
          AppBarConfig.menuAction(
            onPressed: () {
              _showRepairMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.pageMargin),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              SizedBox(height: AppConstants.moduleSpacing),
              _buildFormCard(),
              SizedBox(height: AppConstants.moduleSpacing),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _showRepairMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('报修选项', style: AppTextStyles.h3),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('历史记录', style: AppTextStyles.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('查看历史报修记录')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('报修指南', style: AppTextStyles.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('查看报修填写指南')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: AppConstants.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppConstants.lineSpacing),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.build_outlined,
                  color: Colors.white,
                  size: AppConstants.mediumIconSize,
                ),
              ),
              SizedBox(width: AppConstants.paragraphSpacing),
              Text(
                '报修服务',
                style: AppTextStyles.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.paragraphSpacing),
          Text(
            '请详细填写报修信息，我们会尽快安排维修人员处理',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: AppConstants.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '报修信息',
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConstants.moduleSpacing),
          
          // 问题类型选择
          Text(
            '问题类型',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.lineSpacing),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: '请选择问题类型',
            ),
            items: _categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(
                  category,
                  style: AppTextStyles.body,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          SizedBox(height: AppConstants.sectionSpacing),
          
          // 问题标题
          Text(
            '主要问题',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.lineSpacing),
          TextFormField(
            controller: _titleController,
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: '请简要描述问题',
            ),
            style: AppTextStyles.body,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请填写问题标题';
              }
              return null;
            },
          ),
          SizedBox(height: AppConstants.sectionSpacing),
          
          // 详细描述
          Text(
            '详细描述',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.lineSpacing),
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: '请详细描述问题情况，包括发生时间、位置等',
            ),
            style: AppTextStyles.body,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请填写详细描述';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitRepair,
        style: AppConstants.primaryButtonStyle,
        child: Text(
          '提交报修',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _submitRepair() {
    if (_formKey.currentState!.validate()) {
      // 这里可以添加提交逻辑
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '报修信息已提交，我们会尽快处理',
            style: AppTextStyles.body.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.successColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(AppConstants.pageMargin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
        ),
      );
      
      // 清空表单
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = _categories.first;
      });
    }
  }
} 