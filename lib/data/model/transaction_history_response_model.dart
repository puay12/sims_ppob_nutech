import 'dart:convert';

import 'package:sims_ppob_nutech/domain/entities/transaction_history_response_entity.dart';

TransactionHistoryResponseModel transactionHistoryResponseModelFromJson(String str) 
    => TransactionHistoryResponseModel.fromJson(json.decode(str));
String transactionHistoryResponseModelToJson(TransactionHistoryResponseModel data) => json.encode(data.toJson());

class TransactionHistoryResponseModel extends TransactionHistoryResponseEntity{
  final int status;
  final String message;
  final TransactionHistoryDataModel? data;

  TransactionHistoryResponseModel({
    required this.status,
    required this.message,
    required this.data,
  }) : super(status: status, message: message, data: data);

  factory TransactionHistoryResponseModel.fromJson(Map<String, dynamic> json) => TransactionHistoryResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? TransactionHistoryDataModel.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class TransactionHistoryDataModel extends TransactionHistoryDataEntity {
  final int offset;
  final int limit;
  final List<RecordModel>? records;

  TransactionHistoryDataModel({
    required this.offset,
    required this.limit,
    required this.records,
  }) : super(offset: offset, limit: limit, records: records);

  factory TransactionHistoryDataModel.fromJson(Map<String, dynamic> json) => TransactionHistoryDataModel(
    offset: json["offset"],
    limit: json["limit"],
    records: json["records"] != null
              ? List<RecordModel>.from(json["records"].map((x) => RecordModel.fromJson(x)))
              : null,
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "limit": limit,
    "records": List<dynamic>.from(records!.map((x) => x.toJson())),
  };
}

class RecordModel extends RecordEntity {
  final String invoiceNumber;
  final String transactionType;
  final String description;
  final int totalAmount;
  final DateTime createdOn;

  RecordModel({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  }) : super(
      invoiceNumber: invoiceNumber,
      transactionType: transactionType,
      description: description,
      totalAmount: totalAmount,
      createdOn: createdOn
  );

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
    invoiceNumber: json["invoice_number"],
    transactionType: json["transaction_type"],
    description: json["description"],
    totalAmount: json["total_amount"],
    createdOn: DateTime.parse(json["created_on"]),
  );

  Map<String, dynamic> toJson() => {
    "invoice_number": invoiceNumber,
    "transaction_type": transactionType,
    "description": description,
    "total_amount": totalAmount,
    "created_on": createdOn.toIso8601String(),
  };
}