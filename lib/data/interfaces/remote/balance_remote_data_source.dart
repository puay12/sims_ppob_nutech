import 'package:sims_ppob_nutech/data/model/balance_response_model.dart';

abstract class BalanceRemoteDataSource {
  Future<BalanceResponseModel> getInquiryBalance(String token);
}