import 'package:sims_ppob_nutech/domain/entities/transaction_history_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/transaction_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class GetTransactionHistoryUsecase implements UseCase<TransactionHistoryResponseEntity, int> {
  AuthRepository _authRepository;
  TransactionRepository _transactionRepository;

  GetTransactionHistoryUsecase(this._transactionRepository, this._authRepository);

  @override
  Future<TransactionHistoryResponseEntity> call({int? params}) async {
    final token = await _authRepository.getToken();

    return await _transactionRepository.getHistory(token, params!.toString());
  }

}