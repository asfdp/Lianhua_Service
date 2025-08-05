import 'dart:async';

import 'package:lianhua/features/home/data/banner.dart';

class BannerService {
  static final BannerService _instance = BannerService._internal();
  factory BannerService() => _instance;
  BannerService._internal();

  final StreamController<List<BannerModel>> _controller =
      StreamController<List<BannerModel>>.broadcast();

  List<BannerModel> _banners = [];

  Stream<List<BannerModel>> get bannerStream => _controller.stream;

  List<BannerModel> get currentBanners => _banners;

  Future<void> initialize() async {
    // TODO: Implement banner loading logic
    _controller.add(_banners);
  }
}
