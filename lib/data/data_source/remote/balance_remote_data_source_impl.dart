import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/balance_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/balance_response_model.dart';

class BalanceRemoteDataSourceImpl implements BalanceRemoteDataSource {
  @override
  Future<BalanceResponseModel> getInquiryBalance(String token) async {
    final response = await http.get(Uri.parse(baseUrl + balanceUrl), headers: {
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    final result = BalanceResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }

}