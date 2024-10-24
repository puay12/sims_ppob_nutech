import 'package:sims_ppob_nutech/data/interfaces/remote/transaction_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/transaction_history_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRemoteDataSource _transactionRemoteDataSource;

  TransactionRepositoryImpl(this._transactionRemoteDataSource);

  @override
  Future<TransactionHistoryResponseEntity> getHistory(String token, String offset) async {
    return await _transactionRemoteDataSource.getHistory(token, offset);
  }

}