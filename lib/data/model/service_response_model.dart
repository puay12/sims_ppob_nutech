import 'dart:convert';

import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';

ServiceResponseModel serviceResponseModelFromJson(String str) => ServiceResponseModel.fromJson(json.decode(str));
String serviceResponseModelToJson(ServiceResponseModel data) => json.encode(data.toJson());

class ServiceResponseModel extends ServiceResponseEntity {
  final int status;
  final String message;
  final List<ServiceDataModel>? data;

  ServiceResponseModel({
    required this.status,
    required this.message,
    required this.data,
  }) : super(status: status, message: message, data: data);

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) => ServiceResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] != null ? List<ServiceDataModel>.from(json["data"].map((x) => ServiceDataModel.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
  };
}

class ServiceDataModel extends ServiceDataEntity {
  final String serviceCode;
  final String serviceName;
  final String serviceIcon;
  final int serviceTariff;

  ServiceDataModel({
    required this.serviceCode,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceTariff,
  }) : super(serviceCode: serviceCode, serviceName: serviceName, serviceIcon: serviceIcon, serviceTariff: serviceTariff);

  factory ServiceDataModel.fromJson(Map<String, dynamic> json) => ServiceDataModel(
    serviceCode: json["service_code"],
    serviceName: json["service_name"],
    serviceIcon: json["service_icon"],
    serviceTariff: json["service_tariff"],
  );

  Map<String, dynamic> toJson() => {
    "service_code": serviceCode,
    "service_name": serviceName,
    "service_icon": serviceIcon,
    "service_tariff": serviceTariff,
  };
}
