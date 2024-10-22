import 'dart:convert';
import 'package:sims_ppob_nutech/domain/entities/auth/regist_response_entity.dart';

RegistResponseModel loginResponseEntityFromJson(String str) => RegistResponseModel.fromJson(json.decode(str));
String loginResponseEntityToJson(RegistResponseModel data) => json.encode(data.toJson());

class RegistResponseModel extends RegistResponseEntity {
  final int status;
  final String message;
  final dynamic data;

  RegistResponseModel({
    required this.status,
    required this.message,
    this.data,
  }) : super(status: status, message: message, data: data);

  factory RegistResponseModel.fromJson(Map<String, dynamic> json) => RegistResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}