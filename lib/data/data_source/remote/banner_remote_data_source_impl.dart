import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sims_ppob_nutech/common/constants.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/banner_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/model/banner_response_model.dart';

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  @override
  Future<BannerResponseModel> getBanners(String token) async {
    final response = await http.get(Uri.parse(baseUrl + bannerUrl), headers: {
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    });
    final result = BannerResponseModel.fromJson(jsonDecode(response.body));

    return result;
  }

}