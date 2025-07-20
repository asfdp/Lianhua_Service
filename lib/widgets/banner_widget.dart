import 'package:flutter/material.dart';
import 'dart:async';

class BannerWidget extends StatefulWidget {
  final List<String> images;
  final double height;
  final Duration autoPlayDuration;

  const BannerWidget({
    Key? key,
    required this.images,
    this.height = 150,
    this.autoPlayDuration = const Duration(milliseconds: 3000),
  }) : super(key: key);

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
          duration: Duration(milliseconds: 700),
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
    Timer(Duration(milliseconds: 1000), () {
      _startBannerTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: widget.height,
      child: Stack(
        children: [
          // 轮播图
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      widget.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: widget.height,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Colors.blue[300]!, Colors.blue[100]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '图片加载失败',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
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
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.5),
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