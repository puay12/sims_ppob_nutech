import 'package:equatable/equatable.dart';

class TopupResponseEntity extends Equatable {
  final int status;
  final String message;
  final TopupDataEntity? data;

  TopupResponseEntity({
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

class TopupDataEntity extends Equatable {
  final int balance;

  TopupDataEntity({
    required this.balance,
  });

  @override
  List<Object?> get props {
    return [ balance ];
  }

}