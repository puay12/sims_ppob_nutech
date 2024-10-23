import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/balance_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class GetBalanceUsecase implements UseCase<BalanceResponseEntity, void> {
  BalanceRepository _balanceRepository;
  AuthRepository _authRepository;

  GetBalanceUsecase(this._balanceRepository, this._authRepository);

  @override
  Future<BalanceResponseEntity> call({void params}) async {
    final token = await _authRepository.getToken();

    return await _balanceRepository.getInquiryBalance(token);
  }

}