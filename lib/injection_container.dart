import 'package:get_it/get_it.dart';
import 'package:sims_ppob_nutech/data/data_source/auth/auth_local_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/auth/auth_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth/auth_local_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth/auth_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/repository/auth_repository_impl.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/usecase/login_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/regist_usecase.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //  Data sources
  sl.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl());
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  //  Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));

  sl.registerSingleton<RegistUseCase>(RegistUseCase(sl()));

  //  Provider
  sl.registerSingleton<AuthProvider>(AuthProvider(sl(), sl()));
}