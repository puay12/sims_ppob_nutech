import 'package:sims_ppob_nutech/data/model/banner_response_model.dart';

abstract class BannerRemoteDataSource {
  Future<BannerResponseModel> getBanners(String token);
}