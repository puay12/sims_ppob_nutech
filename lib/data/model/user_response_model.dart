import 'dart:convert';

import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';

UserResponseModel userResponseModelFromJson(String str) => UserResponseModel.fromJson(json.decode(str));
String userResponseModelToJson(UserResponseModel data) => json.encode(data.toJson());

class UserResponseModel extends UserResponseEntity {
  final int status;
  final String message;
  final UserDataModel? data;

  UserResponseModel({
    required this.status,
    required this.message,
    required this.data,
  }) : super(status: status, message: message, data: data);

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? UserDataModel.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserDataModel extends UserDataEntity {
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  UserDataModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  }) : super(email: email, firstName: firstName, lastName: lastName, profileImage: profileImage);

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
  };
}