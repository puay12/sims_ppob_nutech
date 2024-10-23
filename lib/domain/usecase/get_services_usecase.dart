import 'package:sims_ppob_nutech/data/interfaces/auth_local_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/service_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class GetServicesUsecase implements UseCase<ServiceResponseEntity, void> {
  AuthLocalDataSource _authLocalDataSource;
  ServiceRemoteDataSource _serviceRemoteDataSource;

  GetServicesUsecase(this._authLocalDataSource, this._serviceRemoteDataSource);

  @override
  Future<ServiceResponseEntity> call({void params}) async {
    final token = await _authLocalDataSource.getToken();

    return await _serviceRemoteDataSource.getServices(token);
  }

}