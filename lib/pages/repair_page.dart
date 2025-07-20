import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';

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
        title: Text('投票报修'),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              SizedBox(height: 16),
              _buildFormCard(),
              SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.primaryBlue,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '请详细填写报修信息，我们会尽快安排维修人员处理',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '报修信息',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextColor,
            ),
          ),
          SizedBox(height: 16),
          
          // 问题类型选择
          Text(
            '问题类型',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryTextColor,
            ),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: _categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          SizedBox(height: 16),
          
          // 问题标题
          Text(
            '问题标题',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryTextColor,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: '请简要描述问题',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请填写问题标题';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          
          // 详细描述
          Text(
            '详细描述',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryTextColor,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: '请详细描述问题情况，包括发生时间、位置等',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
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
      height: 48,
      child: ElevatedButton(
        onPressed: _submitRepair,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          '提交报修',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
          content: Text('报修信息已提交，我们会尽快处理'),
          backgroundColor: AppColors.successColor,
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