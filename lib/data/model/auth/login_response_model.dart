import 'dart:convert';
import 'package:sims_ppob_nutech/domain/entities/auth/login_response_entity.dart';

LoginResponseModel loginResponseEntityFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
String loginResponseEntityToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel extends LoginResponseEntity {
  final int status;
  final String message;
  final LoginData? data;

  LoginResponseModel({
    required this.status,
    required this.message,
    this.data,
  }) : super(status: status, message: message, data: data);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    message: json["message"],
    data: LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoginData extends LoginDataEntity {
  final String token;

  LoginData({
    required this.token,
  }) : super(token: '');

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}