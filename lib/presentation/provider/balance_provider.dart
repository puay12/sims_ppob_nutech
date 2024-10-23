import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_balance_usecase.dart';

class BalanceProvider extends ChangeNotifier {
  GetBalanceUsecase _getBalanceUsecase;

  BalanceProvider(this._getBalanceUsecase);

  bool isLoading = false;
  bool isGetBalanceSucceed = false;
  int? _balanceData;
  String _message = "";

  String get message => _message;
  int? get balanceData => _balanceData;

  Future<BalanceResponseEntity> getInquiryBalance() async {
    isLoading = true;
    notifyListeners();
    final result = await _getBalanceUsecase();

    if (result.data != null) {
      isGetBalanceSucceed = true;
      _balanceData = result.data?.balance;
    } else {
      _balanceData = 0;
    }

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return result;
  }
}