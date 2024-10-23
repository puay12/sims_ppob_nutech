import 'package:sims_ppob_nutech/data/interfaces/remote/service_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  ServiceRemoteDataSource _serviceRemoteDataSource;

  ServiceRepositoryImpl(this._serviceRemoteDataSource);

  @override
  Future<ServiceResponseEntity> getServices(String token) async {
    return await _serviceRemoteDataSource.getServices(token);
  }

}