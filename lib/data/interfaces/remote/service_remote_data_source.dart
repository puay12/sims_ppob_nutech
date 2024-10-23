import 'package:sims_ppob_nutech/data/model/service_response_model.dart';

abstract class ServiceRemoteDataSource {
  Future<ServiceResponseModel> getServices(String token);
}