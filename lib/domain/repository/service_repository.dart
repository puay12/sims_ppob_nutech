import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';

abstract class ServiceRepository {
  Future<ServiceResponseEntity> getServices(String token);
}