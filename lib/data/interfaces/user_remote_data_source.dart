import 'dart:io';
import 'package:sims_ppob_nutech/data/model/user_response_model.dart';

abstract class UserRemoteDataSource {
  Future<UserResponseModel> getProfile(String token);
  Future<UserResponseModel> updateProfile(String token, String firstName, String lastName);
  Future<UserResponseModel> updateProfileImage(String token, File image);
}