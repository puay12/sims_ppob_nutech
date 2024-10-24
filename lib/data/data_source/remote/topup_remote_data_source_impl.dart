import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/topup_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/top_up_response_model.dart';

class TopupRemoteDataSourceImpl implements TopupRemoteDataSource {
  @override
  Future<TopupResponseModel> performTopup(String token, int topUpAmount) async {
    final response = await http.post(
        Uri.parse(baseUrl + topupUrl),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: <String, String> {
          "top_up_amount" : topUpAmount.toString(),
        }
    );
    final result = TopupResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }

}