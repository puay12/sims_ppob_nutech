import 'dart:io';

import 'package:sims_ppob_nutech/data/interfaces/user_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/user_respository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<UserResponseEntity> getProfile(String token) async {
    return await _userRemoteDataSource.getProfile(token);
  }

  @override
  Future<UserResponseEntity> updateProfile(String token, String firstName, String lastName) async {
    return await _userRemoteDataSource.updateProfile(token, firstName, lastName);
  }

  @override
  Future<UserResponseEntity> updateProfileImage(String token, File image) async {
    return await _userRemoteDataSource.updateProfileImage(token, image);
  }
  
}