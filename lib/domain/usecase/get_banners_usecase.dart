import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/banner_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class GetBannersUsecase implements UseCase<BannerResponseEntity, void> {
  AuthRepository _authRepository;
  BannerRepository _bannerRepository;

  GetBannersUsecase(this._bannerRepository, this._authRepository);

  @override
  Future<BannerResponseEntity> call({void params}) async {
    final token = await _authRepository.getToken();

    return await _bannerRepository.getBanners(token);
  }

}