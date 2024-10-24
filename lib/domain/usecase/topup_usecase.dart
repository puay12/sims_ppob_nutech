import 'package:sims_ppob_nutech/domain/entities/top_up_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/topup_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class TopupUsecase implements UseCase<TopupResponseEntity, int> {
  AuthRepository _authRepository;
  TopupRepository _topupRepository;

  TopupUsecase(this._topupRepository, this._authRepository);

  @override
  Future<TopupResponseEntity> call({int? params}) async {
    final token = await _authRepository.getToken();

    return await _topupRepository.performTopup(token, params!);
  }

}