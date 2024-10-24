import 'package:sims_ppob_nutech/data/interfaces/remote/topup_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/top_up_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/topup_repository.dart';

class TopupRepositoryImpl implements TopupRepository {
  TopupRemoteDataSource _topupRemoteDataSource;

  TopupRepositoryImpl(this._topupRemoteDataSource);

  @override
  Future<TopupResponseEntity> performTopup(String token, int topUpAmount) async {
    return await _topupRemoteDataSource.performTopup(token, topUpAmount);
  }

}