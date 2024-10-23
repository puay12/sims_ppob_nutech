import 'package:get_it/get_it.dart';
import 'package:sims_ppob_nutech/data/data_source/auth/auth_local_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/auth/auth_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/balance_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/user_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth/auth_local_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth/auth_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/balance_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/user_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/repository/auth_repository_impl.dart';
import 'package:sims_ppob_nutech/data/repository/balance_repository_impl.dart';
import 'package:sims_ppob_nutech/data/repository/user_respository_impl.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/balance_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/user_respository.dart';
import 'package:sims_ppob_nutech/domain/usecase/auth/login_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/auth/regist_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_balance_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/user/get_profile_usecase.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/user_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //  Data sources
  sl.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl());
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  sl.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImpl());
  sl.registerSingleton<BalanceRemoteDataSource>(BalanceRemoteDataSourceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));
  sl.registerSingleton<BalanceRepository>(BalanceRepositoryImpl(sl()));

  //  Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegistUseCase>(RegistUseCase(sl()));
  sl.registerSingleton<GetProfileUseCase>(GetProfileUseCase(sl(), sl()));
  sl.registerSingleton<GetBalanceUsecase>(GetBalanceUsecase(sl(), sl()));

  //  Provider
  sl.registerSingleton<AuthProvider>(AuthProvider(sl(), sl()));
  sl.registerSingleton<UserProvider>(UserProvider(sl()));
  sl.registerSingleton<BalanceProvider>(BalanceProvider(sl()));
}