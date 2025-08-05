import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lianhua/core/constants/app_constants.dart';
import 'package:lianhua/core/theme/app_colors.dart';
import 'package:lianhua/core/theme/app_text_styles.dart';

class BannerWidget extends StatefulWidget {
  final List<String> images;
  final double height;
  final Duration autoPlayDuration;

  const BannerWidget({
    super.key,
    required this.images,
    this.height = 150,
    this.autoPlayDuration = const Duration(milliseconds: 3000),
  });

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (_currentIndex < widget.images.length - 1) {
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

  void pauseBannerTimer() {
    _bannerTimer?.cancel();
  }

  void resumeBannerTimer() {
    pauseBannerTimer();
    _startBannerTimer();
  }

  void delayedResumeBannerTimer() {
    pauseBannerTimer();
    Timer(AppConstants.bannerResumeDelay, () {
      _startBannerTimer();
    });
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
      child: Stack(
        children: [
          // 轮播图
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            child: GestureDetector(
              onPanDown: (details) {
                pauseBannerTimer();
              },
              onPanEnd: (details) {
                delayedResumeBannerTimer();
              },
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppConstants.cardRadius,
                      ),
                    ),
                    child: Image.asset(
                      widget.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: widget.height,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppConstants.cardRadius,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accentColor.withValues(alpha: 0.8),
                                AppColors.primaryVariant1.withValues(
                                  alpha: 0.6,
                                ),
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
                                  style: AppTextStyles.body.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // 指示器
          Positioned(
            bottom: AppConstants.pageMargin,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
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
      ),
    );
  }
}
