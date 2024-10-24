import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/entities/top_up_response_entity.dart';
import 'package:sims_ppob_nutech/domain/usecase/topup_usecase.dart';

class TopupProvider extends ChangeNotifier {
  TopupUsecase _topupUsecase;

  TopupProvider(this._topupUsecase);

  bool isLoading = false;
  bool isTopupSucceed = false;
  String _message = "";

  String get message => _message;

  Future<TopupResponseEntity> performTopup(int topUpAmount) async {
    isLoading = true;
    notifyListeners();
    final result = await _topupUsecase(params: topUpAmount);

    if (result.data != null) {
      isTopupSucceed = true;
    }

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return result;
  }
}