import 'package:sims_ppob_nutech/data/model/auth/login_response_model.dart';
import 'package:sims_ppob_nutech/data/model/auth/regist_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
  Future<RegistResponseModel> register(String email, String firstName, String lastName, String password);
}