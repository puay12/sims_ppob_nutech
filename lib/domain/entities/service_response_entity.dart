import 'package:equatable/equatable.dart';

class ServiceResponseEntity extends Equatable {
  final int status;
  final String message;
  final List<ServiceDataEntity>? data;

  ServiceResponseEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props {
    return[
      status, message, data
    ];
  }

}

class ServiceDataEntity extends Equatable {
  final String serviceCode;
  final String serviceName;
  final String serviceIcon;
  final int serviceTariff;

  ServiceDataEntity({
    required this.serviceCode,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceTariff,
  });

  List<Object?> get props {
    return[
      serviceCode, serviceName, serviceIcon, serviceTariff
    ];
  }
}