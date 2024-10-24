import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/entities/transaction_history_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_transaction_history_usecase.dart';

class TransactionProvider extends ChangeNotifier {
  GetTransactionHistoryUsecase _getTransactionHistoryUsecase;

  TransactionProvider(this._getTransactionHistoryUsecase);

  bool isLoading = false;
  bool isGetHistorySucceed = false;
  bool isDoTransactionSucceed = false;
  TransactionHistoryDataEntity? _historyData;
  String _message = "";

  String get message => _message;
  TransactionHistoryDataEntity? get historyData => _historyData;

  Future<TransactionHistoryResponseEntity> getHistory(int offset) async {
    isLoading = true;
    notifyListeners();
    final result = await _getTransactionHistoryUsecase(params: offset);

    if (result.data != null) {
      isGetHistorySucceed = true;
    }

    _historyData = result.data;

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return result;
  }
}