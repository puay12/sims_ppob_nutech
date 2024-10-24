import 'package:sims_ppob_nutech/data/model/top_up_response_model.dart';

abstract class TopupRemoteDataSource {
  Future<TopupResponseModel> performTopup(String token, int topUpAmount);
}