import 'package:sims_ppob_nutech/domain/entities/auth/regist_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class RegistUseCase implements UseCase<RegistResponseEntity, Map<String, String>> {
  final AuthRepository _authRepository;

  RegistUseCase(this._authRepository);

  Future<RegistResponseEntity> call({Map<String, String>? params}) async {
    return await _authRepository.register(
      params!['email']!,
      params['firstName']!,
      params['lastName']!,
      params['password']!
    );
  }
}