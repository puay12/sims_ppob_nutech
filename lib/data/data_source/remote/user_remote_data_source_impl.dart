import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/user_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/user_response_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserResponseModel> getProfile(String token) async {
    final response = await http.get(Uri.parse(baseUrl + profileUrl), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    final result = UserResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }

  @override
  Future<UserResponseModel> updateProfile(String token, String firstName, String lastName) async {
    final response = await http.put(
      Uri.parse(baseUrl + profileUpdateUrl),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${token}"
      },
      body: <String, String> {
        'first_name': firstName,
        'last_name' : lastName
      }
    );
    final result = UserResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }

  @override
  Future<UserResponseModel> updateProfileImage(String token, File image) async {
    final request = http.MultipartRequest('PUT', Uri.parse(baseUrl + profileImageUrl));
    request.headers["authorization"] = "Bearer ${token}";

    final response = await request.send();
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);

    final result = UserResponseModel.fromJson(jsonDecode(responseString));

    return result;
  }

}