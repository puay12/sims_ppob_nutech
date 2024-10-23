import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_banners_usecase.dart';

class BannerProvider extends ChangeNotifier {
  GetBannersUsecase _getBannersUsecase;
  
  BannerProvider(this._getBannersUsecase);
  
  bool isLoading = false;
  bool isGetBannersSucceed = false;
  List<BannerDataEntity>? _bannerData;
  String _message = "";

  String get message => _message;
  List<BannerDataEntity>? get bannerData => _bannerData;

  Future<BannerResponseEntity> getBanners() async {
    isLoading = true;
    notifyListeners();
    final result = await _getBannersUsecase();

    if (result.data != null) {
      isGetBannersSucceed = true;
    }

    _bannerData = result.data;
    _message = result.message;
    isLoading = false;
    notifyListeners();

    return result;
  }
}