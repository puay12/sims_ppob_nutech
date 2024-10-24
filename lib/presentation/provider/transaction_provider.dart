import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_transaction_history_usecase.dart';

class TransactionProvider extends ChangeNotifier {
  GetTransactionHistoryUsecase _getTransactionHistoryUsecase;

  TransactionProvider(this._getTransactionHistoryUsecase);

  bool isLoading = false;
}