import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/app_colors.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<Map<String, dynamic>> _bills = [
    {
      'title': '物业管理费',
      'period': '2023年7月',
      'amount': 350.00,
      'status': '未缴费',
      'dueDate': '2023-07-31',
    },
    {
      'title': '停车费',
      'period': '2023年7月',
      'amount': 150.00,
      'status': '未缴费',
      'dueDate': '2023-07-31',
    },
    {
      'title': '物业管理费',
      'period': '2023年6月',
      'amount': 350.00,
      'status': '已缴费',
      'dueDate': '2023-06-30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('物业收费'),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: 16),
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
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: AppColors.primaryBlue,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '缴费概览',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem('待缴费项目', '${unpaidBills.length}项'),
              _buildSummaryItem('待缴费金额', '¥${totalAmount.toStringAsFixed(2)}'),
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
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondaryTextColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTextColor,
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTextColor,
          ),
        ),
        SizedBox(height: 12),
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
      margin: EdgeInsets.only(bottom: 12),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bill['title'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isUnpaid ? AppColors.warningColor.withOpacity(0.1) : AppColors.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  bill['status'],
                  style: TextStyle(
                    fontSize: 12,
                    color: isUnpaid ? AppColors.warningColor : AppColors.successColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '缴费周期：${bill['period']}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '截止日期：${bill['dueDate']}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondaryTextColor,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '¥${bill['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              if (isUnpaid)
                ElevatedButton(
                  onPressed: () => _payBill(bill),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    '立即缴费',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
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
          title: Text('确认缴费'),
          content: Text('确认缴费 ${bill['title']} ¥${bill['amount'].toStringAsFixed(2)}？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('缴费成功！'),
                    backgroundColor: AppColors.successColor,
                  ),
                );
                setState(() {
                  bill['status'] = '已缴费';
                });
              },
              child: Text('确认'),
            ),
          ],
        );
      },
    );
  }
} 