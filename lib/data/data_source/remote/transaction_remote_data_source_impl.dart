import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/transaction_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/transaction_history_response_model.dart';

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  Future<TransactionHistoryResponseModel> getHistory(String token, String offset) async {
    final response = await http.get(
      Uri.parse("$baseUrl$transactionHistoryUrl?offset=$offset&limit=5"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      }
    );

    final result = TransactionHistoryResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }
  
}