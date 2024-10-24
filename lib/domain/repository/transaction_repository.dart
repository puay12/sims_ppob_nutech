import 'package:sims_ppob_nutech/domain/entities/transaction_history_response_entity.dart';

abstract class TransactionRepository {
  Future<TransactionHistoryResponseEntity> getHistory(String token, String offset);
}