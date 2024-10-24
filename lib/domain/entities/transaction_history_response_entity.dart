import 'package:equatable/equatable.dart';

class TransactionHistoryResponseEntity extends Equatable {
  final int status;
  final String message;
  final TransactionHistoryDataEntity? data;

  TransactionHistoryResponseEntity({
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

class TransactionHistoryDataEntity extends Equatable {
  final int offset;
  final int limit;
  final List<RecordEntity>? records;

  TransactionHistoryDataEntity({
    required this.offset,
    required this.limit,
    required this.records,
  });

  @override
  List<Object?> get props {
    return [
      offset, limit, records
    ];
  }

}

class RecordEntity extends Equatable {
  final String invoiceNumber;
  final String transactionType;
  final String description;
  final int totalAmount;
  final DateTime createdOn;

  RecordEntity({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  });

  @override
  List<Object?> get props {
    return [
      invoiceNumber, transactionType, description, totalAmount, createdOn
    ];
  }
}

