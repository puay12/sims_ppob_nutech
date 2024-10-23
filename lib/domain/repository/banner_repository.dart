import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';

abstract class BannerRepository {
  Future<BannerResponseEntity> getBanners(String token);
}