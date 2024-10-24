import 'package:sims_ppob_nutech/domain/entities/top_up_response_entity.dart';

abstract class TopupRepository {
  Future<TopupResponseEntity> performTopup(String token, int topUpAmount);
}