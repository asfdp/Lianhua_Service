import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lianhua/features/messages/data/message.dart';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';
import 'package:lianhua/core/services/navigation_service.dart';

/// P1 - 消息列表页（MessageList）
/// 核心作用：列出所有发给"我"的定向消息
/// 数据来源：定向消息接口
class MessageListPage extends StatefulWidget {
  const MessageListPage({super.key});

  @override
  MessageListPageState createState() => MessageListPageState();
}

class MessageListPageState extends State<MessageListPage> {
  bool _isLoading = true;
  List<Message> _messages = [];
  String _selectedFilter = '全部';
  final List<String> _filterOptions = [
    '全部',
    '未读',
    '系统消息',
    '物业通知',
    '缴费提醒',
    '报修回复',
  ];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  /// 加载消息数据（模拟）
  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    // 模拟网络请求延迟
    await Future.delayed(Duration(milliseconds: 1000));

    // 模拟消息数据
    final mockMessages = [
      Message(
        id: '1',
        title: '物业费缴费提醒',
        content:
            '尊敬的业主您好：您的2025年1月物业管理费已到缴费时间，请及时缴费。缴费金额：850元，缴费截止日期：2025年1月31日。',
        summary: '您的2025年1月物业管理费已到缴费时间，缴费金额：850元',
        createTime: DateTime.now().subtract(Duration(hours: 2)),
        isRead: false,
        senderName: '物业财务部',
        type: MessageType.payment,
      ),
      Message(
        id: '2',
        title: '报修进度通知',
        content:
            '您提交的"卫生间水龙头滴水"报修单已处理完成，维修师傅：张师傅，完成时间：2025年1月10日 15:30。如有问题请及时联系物业。',
        summary: '您的报修单"卫生间水龙头滴水"已处理完成',
        createTime: DateTime.now().subtract(Duration(days: 1)),
        isRead: true,
        senderName: '维修部',
        type: MessageType.repair,
      ),
      Message(
        id: '3',
        title: '新年活动邀请',
        content:
            '滇池卫城新年联欢会将于1月25日晚19:00在小区会所举行，诚邀您和家人参加。活动内容包括文艺表演、抽奖等，报名截止1月20日。',
        summary: '滇池卫城新年联欢会邀请，1月25日晚19:00',
        createTime: DateTime.now().subtract(Duration(days: 2)),
        isRead: false,
        senderName: '社区服务中心',
        type: MessageType.activity,
      ),
      Message(
        id: '4',
        title: '停水通知',
        content: '由于小区供水设备维护，1月15日上午9:00-12:00将临时停水，请提前做好储水准备。给您带来不便，敬请谅解。',
        summary: '1月15日上午9:00-12:00临时停水',
        createTime: DateTime.now().subtract(Duration(days: 3)),
        isRead: true,
        senderName: '物业管理处',
        type: MessageType.property,
      ),
      Message(
        id: '5',
        title: '系统维护通知',
        content: '物业服务APP将于1月18日凌晨2:00-4:00进行系统维护升级，期间部分功能可能无法使用，感谢您的理解与支持。',
        summary: '物业服务APP系统维护通知',
        createTime: DateTime.now().subtract(Duration(days: 5)),
        isRead: true,
        senderName: '系统管理员',
        type: MessageType.system,
      ),
    ];

    setState(() {
      _messages = mockMessages;
      _isLoading = false;
    });
  }

  /// 获取过滤后的消息列表
  List<Message> get _filteredMessages {
    switch (_selectedFilter) {
      case '未读':
        return _messages.where((msg) => !msg.isRead).toList();
      case '系统消息':
        return _messages
            .where((msg) => msg.type == MessageType.system)
            .toList();
      case '物业通知':
        return _messages
            .where((msg) => msg.type == MessageType.property)
            .toList();
      case '缴费提醒':
        return _messages
            .where((msg) => msg.type == MessageType.payment)
            .toList();
      case '报修回复':
        return _messages
            .where((msg) => msg.type == MessageType.repair)
            .toList();
      default:
        return _messages;
    }
  }

  /// 标记消息为已读
  void _markAsRead(Message message) {
    if (!message.isRead) {
      setState(() {
        final index = _messages.indexWhere((m) => m.id == message.id);
        if (index != -1) {
          _messages[index] = message.copyWith(isRead: true);
        }
      });
    }
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    await _loadMessages();
  }

  /// 构建AppBar
  PreferredSizeWidget _buildAppBar() {
    return GFAppBar(
      title: Text('我的消息'),
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions: [
        // 筛选按钮
        GFIconButton(
          icon: Icon(Icons.filter_list, color: AppColors.primaryTextColor),
          color: AppColors.cardBackground,
          onPressed: () {
            _showFilterDialog();
          },
          tooltip: '筛选消息',
        ),
        // 更多操作按钮
        GFIconButton(
          icon: Icon(Icons.more_vert, color: AppColors.primaryTextColor),
          color: AppColors.cardBackground,
          onPressed: () {
            _showMoreOptionsDialog();
          },
          tooltip: '更多操作',
        ),
      ],
    );
  }

  /// 显示筛选对话框
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('筛选消息'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _filterOptions.map((String option) {
              return ListTile(
                title: Text(option),
                leading: Icon(
                  _selectedFilter == option
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: _selectedFilter == option
                      ? AppColors.accentColor
                      : AppColors.secondaryTextColor,
                ),
                onTap: () {
                  setState(() {
                    _selectedFilter = option;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            GFButton(
              text: '取消',
              type: GFButtonType.outline,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// 显示更多操作对话框
  void _showMoreOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('更多操作'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('全部标记为已读'),
                leading: Icon(Icons.mark_email_read),
                onTap: () {
                  Navigator.of(context).pop();
                  _markAllAsRead();
                },
              ),
              ListTile(
                title: Text('删除已读消息'),
                leading: Icon(Icons.delete_outline),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteReadMessages();
                },
              ),
              ListTile(
                title: Text('消息设置'),
                leading: Icon(Icons.settings_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  _openMessageSettings();
                },
              ),
            ],
          ),
          actions: [
            GFButton(
              text: '取消',
              type: GFButtonType.outline,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// 全部标记为已读
  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _messages.length; i++) {
        if (!_messages[i].isRead) {
          _messages[i] = _messages[i].copyWith(isRead: true);
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已将所有消息标记为已读'),
        backgroundColor: AppColors.accentColor,
      ),
    );
  }

  /// 删除已读消息
  void _deleteReadMessages() {
    setState(() {
      _messages.removeWhere((message) => message.isRead);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已删除所有已读消息'),
        backgroundColor: AppColors.accentColor,
      ),
    );
  }

  /// 打开消息设置
  void _openMessageSettings() {
    // TODO: 实现消息设置页面导航
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('消息设置功能开发中'),
        backgroundColor: AppColors.accentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: _isLoading
          ? Center(
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: AppColors.accentColor,
                loaderColorTwo: AppColors.primaryColor,
                loaderColorThree: AppColors.accentColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.accentColor,
              child: Column(
                children: [
                  // 筛选提示
                  if (_selectedFilter != '全部') _buildFilterTip(),

                  // 消息列表
                  Expanded(
                    child: _filteredMessages.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.pageMargin,
                              vertical: AppConstants.cardSpacing,
                            ),
                            itemCount: _filteredMessages.length,
                            itemBuilder: (context, index) {
                              final message = _filteredMessages[index];
                              return _buildMessageItem(message);
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  /// 构建筛选提示
  Widget _buildFilterTip() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.pageMargin,
        vertical: AppConstants.lineSpacing,
      ),
      color: AppColors.primaryColor,
      child: Text(
        '当前筛选：$_selectedFilter',
        style: AppTextStyles.caption.copyWith(color: AppColors.accentColor),
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail_outline, size: 64, color: AppColors.hintTextColor),
          SizedBox(height: AppConstants.paragraphSpacing),
          Text(
            _selectedFilter == '全部' ? '暂无消息' : '暂无相关消息',
            style: AppTextStyles.h2.copyWith(color: AppColors.hintTextColor),
          ),
          SizedBox(height: AppConstants.lineSpacing),
          Text('下拉可以刷新消息列表', style: AppTextStyles.caption),
        ],
      ),
    );
  }

  /// 构建消息项
  Widget _buildMessageItem(Message message) {
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.cardSpacing),
      decoration: AppConstants.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          onTap: () {
            _markAsRead(message);
            NavigationService.navigateToMessageDetail(context, message);
          },
          child: Padding(
            padding: EdgeInsets.all(AppConstants.pageMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 消息类型图标
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getMessageTypeColor(message.type),
                    borderRadius: BorderRadius.circular(
                      AppConstants.mediumRadius,
                    ),
                  ),
                  child: Icon(
                    _getMessageTypeIcon(message.type),
                    color: Colors.white,
                    size: AppConstants.mediumIconSize,
                  ),
                ),
                SizedBox(width: AppConstants.paragraphSpacing),

                // 消息内容
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题和未读标识
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              message.title,
                              style: AppTextStyles.h2.copyWith(
                                fontWeight: message.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                color: message.isRead
                                    ? AppColors.primaryTextColor
                                    : AppColors.accentColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!message.isRead)
                            Container(
                              margin: EdgeInsets.only(
                                left: AppConstants.lineSpacing,
                              ),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.errorColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: AppConstants.lineSpacing),

                      // 消息摘要
                      Text(
                        message.summary,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppConstants.lineSpacing),

                      // 发送者和时间
                      Row(
                        children: [
                          Text(
                            message.senderName,
                            style: AppTextStyles.caption.copyWith(
                              color: _getMessageTypeColor(message.type),
                            ),
                          ),
                          Spacer(),
                          Text(
                            message.formattedTime,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 获取消息类型图标
  IconData _getMessageTypeIcon(MessageType type) {
    switch (type) {
      case MessageType.system:
        return Icons.settings_outlined;
      case MessageType.property:
        return Icons.business_outlined;
      case MessageType.payment:
        return Icons.payment_outlined;
      case MessageType.repair:
        return Icons.build_outlined;
      case MessageType.activity:
        return Icons.event_outlined;
      default:
        return Icons.mail_outline;
    }
  }

  /// 获取消息类型颜色
  Color _getMessageTypeColor(MessageType type) {
    final colorHex = type.colorHex;
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }
}
