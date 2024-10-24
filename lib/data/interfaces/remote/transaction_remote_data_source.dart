import 'package:sims_ppob_nutech/data/model/transaction_history_response_model.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionHistoryResponseModel> getHistory(String token, String offset);
}