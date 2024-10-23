import 'dart:io';
import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';

abstract class UserRepository {
  Future<UserResponseEntity> getProfile(String token);
  Future<UserResponseEntity> updateProfile(String token, String firstName, String lastName);
  Future<UserResponseEntity> updateProfileImage(String token, File image);
}