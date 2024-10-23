import 'package:sims_ppob_nutech/data/interfaces/balance_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/balance_repository.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  BalanceRemoteDataSource _balanceRemoteDataSource;

  BalanceRepositoryImpl(this._balanceRemoteDataSource);

  @override
  Future<BalanceResponseEntity> getInquiryBalance(String token) async {
    return await _balanceRemoteDataSource.getInquiryBalance(token);
  }

}