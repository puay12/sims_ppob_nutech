import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';

abstract class BalanceRepository {
  Future<BalanceResponseEntity> getInquiryBalance(String token);
}