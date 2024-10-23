import 'package:sims_ppob_nutech/data/interfaces/remote/banner_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  BannerRemoteDataSource _bannerRemoteDataSource;

  BannerRepositoryImpl(this._bannerRemoteDataSource);

  @override
  Future<BannerResponseEntity> getBanners(String token) async {
    return await _bannerRemoteDataSource.getBanners(token);
  }
  
}