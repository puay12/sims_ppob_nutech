import 'package:get_it/get_it.dart';
import 'package:sims_ppob_nutech/data/data_source/remote/balance_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/local/auth_local_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/remote/banner_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/remote/service_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/data_source/remote/user_remote_data_source_impl.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth_local_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/auth_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/balance_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/banner_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/service_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/user_remote_data_source.dart';
import 'package:sims_ppob_nutech/data/repository/auth_repository_impl.dart';
import 'package:sims_ppob_nutech/data/repository/balance_repository_impl.dart';
import 'package:sims_ppob_nutech/data/repository/banner_repository_impl.dart';
import 'package:sims_ppob_nutech/data/repository/service_repository_impl.dart';
import 'package:sims_ppob_nutech/data/repository/user_respository_impl.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/balance_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/banner_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/service_repository.dart';
import 'package:sims_ppob_nutech/domain/repository/user_respository.dart';
import 'package:sims_ppob_nutech/domain/usecase/auth/login_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/auth/regist_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_balance_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_banners_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/get_services_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/user/get_profile_usecase.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/banner_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/get_service_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/user_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //  Data sources
  sl.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl());
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  sl.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImpl());
  sl.registerSingleton<BalanceRemoteDataSource>(BalanceRemoteDataSourceImpl());
  sl.registerSingleton<ServiceRemoteDataSource>(ServiceRemoteDataSourceImpl());
  sl.registerSingleton<BannerRemoteDataSource>(BannerRemoteDataSourceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));
  sl.registerSingleton<BalanceRepository>(BalanceRepositoryImpl(sl()));
  sl.registerSingleton<ServiceRepository>(ServiceRepositoryImpl(sl()));
  sl.registerSingleton<BannerRepository>(BannerRepositoryImpl(sl()));

  //  Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegistUseCase>(RegistUseCase(sl()));
  sl.registerSingleton<GetProfileUseCase>(GetProfileUseCase(sl(), sl()));
  sl.registerSingleton<GetBalanceUsecase>(GetBalanceUsecase(sl(), sl()));
  sl.registerSingleton<GetServicesUsecase>(GetServicesUsecase(sl(), sl()));
  sl.registerSingleton<GetBannersUsecase>(GetBannersUsecase(sl(), sl()));

  //  Provider
  sl.registerSingleton<AuthProvider>(AuthProvider(sl(), sl()));
  sl.registerSingleton<UserProvider>(UserProvider(sl()));
  sl.registerSingleton<BalanceProvider>(BalanceProvider(sl()));
  sl.registerSingleton<GetServiceProvider>(GetServiceProvider(sl()));
  sl.registerSingleton<BannerProvider>(BannerProvider(sl()));
}