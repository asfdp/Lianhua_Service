import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';
import 'package:lianhua/features/home/data/banner.dart';
import 'package:lianhua/core/services/banner_service.dart';

class DynamicBannerWidget extends StatefulWidget {
  final double height;
  final Duration autoPlayDuration;
  final VoidCallback? onBannerTap;

  const DynamicBannerWidget({
    super.key,
    this.height = 150,
    this.autoPlayDuration = const Duration(milliseconds: 3000),
    this.onBannerTap,
  });

  @override
  _DynamicBannerWidgetState createState() => _DynamicBannerWidgetState();
}

class _DynamicBannerWidgetState extends State<DynamicBannerWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _bannerTimer;
  List<BannerModel> _banners = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeBanners();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// 初始化轮播图数据
  Future<void> _initializeBanners() async {
    try {
      // 初始化轮播图服务
      await BannerService().initialize();

      // 监听轮播图数据变化
      BannerService().bannerStream.listen((banners) {
        if (mounted) {
          setState(() {
            _banners = banners;
            _isLoading = false;
            _errorMessage = null;
          });

          // 如果有数据，启动轮播
          if (_banners.isNotEmpty) {
            _startBannerTimer();
          }
        }
      });

      // 获取当前数据
      final currentBanners = BannerService().currentBanners;
      if (mounted) {
        setState(() {
          _banners = currentBanners;
          _isLoading = false;
        });

        if (_banners.isNotEmpty) {
          _startBannerTimer();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = '加载轮播图失败';
        });
      }
    }
  }

  /// 启动轮播定时器
  void _startBannerTimer() {
    _bannerTimer?.cancel();
    if (_banners.isEmpty) return;

    _bannerTimer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (_currentIndex < _banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: AppConstants.bannerAnimationDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  /// 暂停轮播定时器
  void _pauseBannerTimer() {
    _bannerTimer?.cancel();
  }

  /// 恢复轮播定时器
  void _resumeBannerTimer() {
    _pauseBannerTimer();
    _startBannerTimer();
  }

  /// 延迟恢复轮播定时器
  void _delayedResumeBannerTimer() {
    _pauseBannerTimer();
    Timer(AppConstants.bannerResumeDelay, () {
      _startBannerTimer();
    });
  }

  /// 处理轮播图点击
  void _onBannerTap(BannerModel banner) {
    if (banner.linkUrl != null && banner.linkUrl!.isNotEmpty) {
      // 这里可以添加处理链接的逻辑，比如打开网页或跳转到指定页面
      print('轮播图链接: ${banner.linkUrl}');
    }
    widget.onBannerTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.pageMargin,
        vertical: AppConstants.cardSpacing,
      ),
      height: widget.height,
      decoration: BoxDecoration(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        child: _buildContent(),
      ),
    );
  }

  /// 构建内容
  Widget _buildContent() {
    if (_isLoading) {
      return _buildLoadingWidget();
    }

    if (_errorMessage != null) {
      return _buildErrorWidget();
    }

    if (_banners.isEmpty) {
      return _buildEmptyWidget();
    }

    return _buildBannerContent();
  }

  /// 构建加载中组件
  Widget _buildLoadingWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor.withValues(alpha: 0.8),
            AppColors.primaryVariant1.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            SizedBox(height: AppConstants.lineSpacing),
            Text(
              '加载中...',
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建错误组件
  Widget _buildErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.errorColor.withValues(alpha: 0.8),
            AppColors.errorColor.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: AppConstants.extraLargeIconSize,
            ),
            SizedBox(height: AppConstants.lineSpacing),
            Text(
              _errorMessage ?? '加载失败',
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
            SizedBox(height: AppConstants.lineSpacing),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                _initializeBanners();
              },
              child: Text(
                '重试',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建空状态组件
  Widget _buildEmptyWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor.withValues(alpha: 0.8),
            AppColors.primaryVariant1.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white,
              size: AppConstants.extraLargeIconSize,
            ),
            SizedBox(height: AppConstants.lineSpacing),
            Text(
              '暂无轮播图',
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建轮播图内容
  Widget _buildBannerContent() {
    return Stack(
      children: [
        // 轮播图
        GestureDetector(
          onPanDown: (details) {
            _pauseBannerTimer();
          },
          onPanEnd: (details) {
            _delayedResumeBannerTimer();
          },
          onTap: () {
            if (_banners.isNotEmpty) {
              _onBannerTap(_banners[_currentIndex]);
            }
          },
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return _buildBannerItem(banner);
            },
          ),
        ),

        // 指示器
        if (_banners.length > 1)
          Positioned(
            bottom: AppConstants.pageMargin,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_banners.length, (index) {
                return Container(
                  width: _currentIndex == index ? 16 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  /// 构建单个轮播图项
  Widget _buildBannerItem(BannerModel banner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Stack(
        children: [
          // 图片
          _buildBannerImage(banner),

          // 标题（如果有）
          if (banner.title != null && banner.title!.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(AppConstants.pageMargin),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Text(
                  banner.title!,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建轮播图片
  Widget _buildBannerImage(BannerModel banner) {
    // 判断是网络图片还是本地图片
    if (banner.imageUrl.startsWith('http://') ||
        banner.imageUrl.startsWith('https://')) {
      // 网络图片
      return Image.network(
        banner.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: widget.height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(color: AppColors.backgroundColor),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: AppColors.accentColor,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage();
        },
      );
    } else {
      // 本地图片
      return Image.asset(
        banner.imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage();
        },
      );
    }
  }

  /// 构建错误图片
  Widget _buildErrorImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor.withValues(alpha: 0.8),
            AppColors.primaryVariant1.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white,
              size: AppConstants.extraLargeIconSize,
            ),
            SizedBox(height: AppConstants.lineSpacing),
            Text(
              '图片加载失败',
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
