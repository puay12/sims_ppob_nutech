import 'package:equatable/equatable.dart';

class BalanceResponseEntity extends Equatable {
  final int status;
  final String message;
  final BalanceDataEntity? data;

  BalanceResponseEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List< Object ? > get props{
    return[
      status, message, data
    ];
  }
}

class BalanceDataEntity extends Equatable {
  final int balance;

  BalanceDataEntity({
    required this.balance,
  });

  @override
  List<Object?> get props {
    return [
      balance
    ];
  }
}