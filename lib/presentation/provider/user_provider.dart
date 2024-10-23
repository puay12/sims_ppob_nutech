import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/user/get_profile_usecase.dart';

class UserProvider extends ChangeNotifier {
  GetProfileUseCase _getProfileUseCase;

  UserProvider(this._getProfileUseCase);

  bool isLoading = false;
  bool isGetProfileSucceed = false;
  bool isProfileUpdated = false;
  bool isProfileImageUpdated = false;
  UserDataEntity? _userData;
  String _message = "";

  String get message => _message;
  UserDataEntity? get userData => _userData;

  Future<UserResponseEntity> getProfile() async {
    isLoading = true;
    notifyListeners();
    final result = await _getProfileUseCase();

    if (result.data != null) {
      isGetProfileSucceed = true;
    }

    _userData = result.data;

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return result;
  }
}