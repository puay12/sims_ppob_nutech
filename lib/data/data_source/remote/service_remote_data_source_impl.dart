import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/service_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/service_response_model.dart';

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  @override
  Future<ServiceResponseModel> getServices(String token) async {
    final response = await http.get(Uri.parse(baseUrl + servicesUrl), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    final result = ServiceResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }
}