import 'package:sims_ppob_nutech/domain/entities/auth/login_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class LoginUseCase implements UseCase<LoginResponseEntity, Map<String, String>> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<LoginResponseEntity> call({Map<String, String>? params}) async {
    final result = await _authRepository.login(params!['email']!, params['password']!);

    if (result.data != null) {
      await _authRepository.setToken(result.data!.token!);
    }

    return result;
  }
}