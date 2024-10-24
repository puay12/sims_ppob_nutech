import 'dart:convert';

import 'package:sims_ppob_nutech/domain/entities/top_up_response_entity.dart';

TopupResponseModel topupResponseModelFromJson(String str) => TopupResponseModel.fromJson(json.decode(str));
String topupResponseModelToJson(TopupResponseModel data) => json.encode(data.toJson());

class TopupResponseModel extends TopupResponseEntity {
  final int status;
  final String message;
  final TopupDataModel? data;

  TopupResponseModel({
    required this.status,
    required this.message,
    required this.data,
  }) : super(status: status, message: message, data: data);

  factory TopupResponseModel.fromJson(Map<String, dynamic> json) => TopupResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? TopupDataModel.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class TopupDataModel extends TopupDataEntity {
  final int balance;

  TopupDataModel({
    required this.balance,
  }) : super(balance: balance);

  factory TopupDataModel.fromJson(Map<String, dynamic> json) => TopupDataModel(
    balance: int.parse(json["balance"]),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
  };
}
