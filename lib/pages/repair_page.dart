import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class RepairPage extends StatefulWidget {
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
      appBar: AppBar(
        title: Text(
          '投票报修',
          style: AppTextStyles.h1.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.accentColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
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

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryVariant1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: AppConstants.shadowBlurRadius,
            spreadRadius: AppConstants.shadowSpreadRadius,
            offset: AppConstants.shadowOffset,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.lineSpacing),
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: AppConstants.mediumIconSize,
            ),
          ),
          SizedBox(width: AppConstants.paragraphSpacing),
          Expanded(
            child: Text(
              '请详细填写报修信息，我们会尽快安排维修人员处理',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primaryTextColor,
              ),
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
            style: AppTextStyles.h1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConstants.moduleSpacing),
          
          // 问题类型选择
          Text(
            '问题类型',
            style: AppTextStyles.h2.copyWith(
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
            '问题标题',
            style: AppTextStyles.h2.copyWith(
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
            style: AppTextStyles.h2.copyWith(
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