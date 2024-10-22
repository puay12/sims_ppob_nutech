import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth/auth_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/auth/login_response_model.dart';

import '../../model/auth/regist_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + loginUrl), body: <String, String> {
        "email" : email,
        "password" : password
      });

      if (response.statusCode == 200) {
        final result = LoginResponseModel.fromJson(jsonDecode(response.body));

        return result;
      } else {
        throw Exception('Failed to login');
      }
    } catch(e) {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<RegistResponseModel> register(String email, String firstName, String lastName, String password) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + registUrl), body: <String, String> {
        "email" : email,
        "first_name" : firstName,
        "last_name" : lastName,
        "password" : password
      });

      if (response.statusCode == 200) {
        final result = RegistResponseModel.fromJson(jsonDecode(response.body));

        return result;
      } else {
        throw Exception('Failed to Register');
      }
    } catch(e) {
      throw Exception('Failed to Register');
    }
  }

}