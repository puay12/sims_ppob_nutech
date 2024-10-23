import 'dart:convert';
import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';

BalanceResponseModel loginResponseEntityFromJson(String str) => BalanceResponseModel.fromJson(json.decode(str));
String loginResponseEntityToJson(BalanceResponseModel data) => json.encode(data.toJson());

class BalanceResponseModel extends BalanceResponseEntity {
  final int status;
  final String message;
  final BalanceData? data;

  BalanceResponseModel({
    required this.status,
    required this.message,
    required this.data,
  }) : super(status: status, message: message, data: data);

  factory BalanceResponseModel.fromJson(Map<String, dynamic> json) => BalanceResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? BalanceData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class BalanceData extends BalanceDataEntity {
  final int balance;

  BalanceData({
    required this.balance,
  }) : super(balance: balance);

  factory BalanceData.fromJson(Map<String, dynamic> json) => BalanceData(
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
  };
}