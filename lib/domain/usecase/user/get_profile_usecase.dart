import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/user_respository.dart';
import 'package:sims_ppob_nutech/domain/usecase/usecase_generic.dart';

class GetProfileUseCase implements UseCase<UserResponseEntity, void> {
  UserRepository _userRepository;
  AuthRepository _authRepository;

  GetProfileUseCase(this._userRepository, this._authRepository);

  @override
  Future<UserResponseEntity> call({void params}) async {
    final token = await _authRepository.getToken();

    return await _userRepository.getProfile(token);
  }

}