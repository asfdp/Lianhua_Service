import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<Map<String, dynamic>> _bills = [
    {
      'title': '物业管理费',
      'period': '2025年1月',
      'amount': 350.00,
      'status': '未缴费',
      'dueDate': '2025-01-31',
    },
    {
      'title': '停车费',
      'period': '2025年1月',
      'amount': 150.00,
      'status': '未缴费',
      'dueDate': '2025-01-31',
    },
    {
      'title': '物业管理费',
      'period': '2024年12月',
      'amount': 350.00,
      'status': '已缴费',
      'dueDate': '2024-12-31',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          '物业收费',
          style: AppTextStyles.h1.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.accentColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.pageMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: AppConstants.moduleSpacing),
            _buildBillsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final unpaidBills = _bills.where((bill) => bill['status'] == '未缴费').toList();
    final totalAmount = unpaidBills.fold<double>(0.0, (sum, bill) => sum + bill['amount']);

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
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                  size: AppConstants.mediumIconSize,
                ),
              ),
              SizedBox(width: AppConstants.paragraphSpacing),
              Text(
                '缴费概览',
                style: AppTextStyles.h1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.moduleSpacing),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem('待缴费项目', '${unpaidBills.length}项'),
              ),
              SizedBox(width: AppConstants.pageMargin),
              Expanded(
                child: _buildSummaryItem('待缴费金额', '¥${totalAmount.toStringAsFixed(2)}'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.secondaryTextColor,
          ),
        ),
        SizedBox(height: AppConstants.lineSpacing / 2),
        Text(
          value,
          style: AppTextStyles.title.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.accentColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBillsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '缴费记录',
          style: AppTextStyles.h1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppConstants.paragraphSpacing),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _bills.length,
          itemBuilder: (context, index) {
            return _buildBillItem(_bills[index]);
          },
        ),
      ],
    );
  }

  Widget _buildBillItem(Map<String, dynamic> bill) {
    final isUnpaid = bill['status'] == '未缴费';
    
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.paragraphSpacing),
      padding: EdgeInsets.all(AppConstants.pageMargin),
      decoration: BoxDecoration(
        color: isUnpaid ? AppColors.primaryColor : AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: isUnpaid ? AppColors.accentColor.withOpacity(0.3) : AppColors.dividerColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: AppConstants.shadowBlurRadius,
            spreadRadius: AppConstants.shadowSpreadRadius,
            offset: AppConstants.shadowOffset,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bill['title'],
                style: AppTextStyles.h2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.lineSpacing,
                  vertical: AppConstants.lineSpacing / 2,
                ),
                decoration: BoxDecoration(
                  color: isUnpaid 
                      ? AppColors.warningColor.withOpacity(0.1) 
                      : AppColors.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.smallRadius),
                ),
                child: Text(
                  bill['status'],
                  style: AppTextStyles.caption.copyWith(
                    color: isUnpaid ? AppColors.warningColor : AppColors.successColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.lineSpacing),
          Text(
            '缴费周期：${bill['period']}',
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: AppConstants.lineSpacing / 2),
          Text(
            '截止日期：${bill['dueDate']}',
            style: AppTextStyles.body.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: AppConstants.paragraphSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '¥${bill['amount'].toStringAsFixed(2)}',
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentColor,
                ),
              ),
              if (isUnpaid)
                ElevatedButton(
                  onPressed: () => _payBill(bill),
                  style: AppConstants.primaryButtonStyle.copyWith(
                    minimumSize: MaterialStateProperty.all(Size(100, AppConstants.smallButtonHeight)),
                  ),
                  child: Text(
                    '立即缴费',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _payBill(Map<String, dynamic> bill) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          ),
          title: Text(
            '确认缴费',
            style: AppTextStyles.h1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '确认缴费 ${bill['title']} ¥${bill['amount'].toStringAsFixed(2)}？',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.secondaryTextColor,
              ),
              child: Text(
                '取消',
                style: AppTextStyles.body,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '缴费成功！',
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
                setState(() {
                  bill['status'] = '已缴费';
                });
              },
              style: AppConstants.primaryButtonStyle.copyWith(
                minimumSize: MaterialStateProperty.all(Size(80, AppConstants.smallButtonHeight)),
              ),
              child: Text(
                '确认',
                style: AppTextStyles.body.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
} 