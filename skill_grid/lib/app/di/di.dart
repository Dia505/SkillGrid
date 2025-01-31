import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/core/network/api_service.dart';
import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/auth/data/data_source/local_data_source/client_local_data_source.dart';
import 'package:skill_grid/features/auth/data/data_source/local_data_source/freelancer_local_data_source.dart';
import 'package:skill_grid/features/auth/data/data_source/remote_data_source/client_remote_data_source.dart';
import 'package:skill_grid/features/auth/data/data_source/remote_data_source/freelancer_remote_data_source.dart';
import 'package:skill_grid/features/auth/data/repository/client_repository/client_local_repository.dart';
import 'package:skill_grid/features/auth/data/repository/client_repository/client_remote_repository.dart';
import 'package:skill_grid/features/auth/data/repository/freelancer_repository/freelancer_local_repository.dart';
import 'package:skill_grid/features/auth/data/repository/freelancer_repository/freelancer_remote_repository.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/delete_client_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/register_client_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/delete_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/freelancer_login_usec_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_all_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/register_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_cubit.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/freelancer/freelancer_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/freelancer/freelancer_dashboard_cubit.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/onboard_screen/onboard_screen_cubit.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/splash_screen/splash_screen_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  await _initClientRegistrationDependencies();
  await _initFreelancerRegistrationDependencies();
  await _initLoginDependencies();
  await _initJoinAsClientFreelancerDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardScreenDependencies();
  await _initClientDashboardDependencies();
  await _initFreelancerDashboardDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

//Client dependencies
_initClientRegistrationDependencies() async {
  getIt.registerLazySingleton<ClientLocalDataSource>(
      () => ClientLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<ClientRemoteDataSource>(
      () => ClientRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<ClientLocalRepository>(() =>
      ClientLocalRepository(
          clientLocalDataSource: getIt<ClientLocalDataSource>()));
  getIt.registerLazySingleton<ClientRemoteRepository>(() =>
      ClientRemoteRepository(
          clientRemoteDataSource: getIt<ClientRemoteDataSource>()));

  getIt.registerLazySingleton<RegisterClientUseCase>(() =>
      RegisterClientUseCase(clientRepository: getIt<ClientRemoteRepository>()));

  getIt.registerLazySingleton<DeleteClientUseCase>(() =>
      DeleteClientUseCase(clientRepository: getIt<ClientLocalRepository>()));

  getIt.registerLazySingleton<GetClientByIdUseCase>(() =>
      GetClientByIdUseCase(clientRepository: getIt<ClientRemoteRepository>()));

  getIt.registerFactory<ClientBloc>(() => ClientBloc(
      registerClientUseCase: getIt<RegisterClientUseCase>(),
      loginBloc: getIt<LoginBloc>()));
}

//Freelancer dependencies
_initFreelancerRegistrationDependencies() async {
  getIt.registerLazySingleton<FreelancerLocalDataSource>(
      () => FreelancerLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<FreelancerRemoteDataSource>(
      () => FreelancerRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<FreelancerLocalRepository>(() =>
      FreelancerLocalRepository(
          freelancerLocalDataSource: getIt<FreelancerLocalDataSource>()));
  getIt.registerLazySingleton<FreelancerRemoteRepository>(() =>
      FreelancerRemoteRepository(
          freelancerRemoteDataSource: getIt<FreelancerRemoteDataSource>()));

  getIt.registerLazySingleton<RegisterFreelancerUseCase>(() =>
      RegisterFreelancerUseCase(
          freelancerRepository: getIt<FreelancerRemoteRepository>()));

  getIt.registerLazySingleton<DeleteFreelancerUseCase>(() =>
      DeleteFreelancerUseCase(
          freelancerRepository: getIt<FreelancerLocalRepository>()));

  getIt.registerLazySingleton<GetFreelancerByIdUseCase>(() =>
      GetFreelancerByIdUseCase(
          freelancerRepository: getIt<FreelancerLocalRepository>()));

  getIt.registerLazySingleton<GetAllFreelancerUseCase>(() =>
      GetAllFreelancerUseCase(
          freelancerRepository: getIt<FreelancerLocalRepository>()));

  getIt.registerFactory<FreelancerBloc>(() => FreelancerBloc(
      registerFreelancerUseCase: getIt<RegisterFreelancerUseCase>(),
      loginBloc: getIt<LoginBloc>()));
}

//Login dependencies
_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<ClientLoginUseCase>(() => ClientLoginUseCase(
      getIt<ClientRemoteRepository>(), getIt<TokenSharedPrefs>()));

  getIt.registerLazySingleton<FreelancerLoginUseCase>(
      () => FreelancerLoginUseCase(getIt<FreelancerRemoteRepository>()));

  getIt.registerFactory<LoginBloc>(() => LoginBloc(
      clientLoginUseCase: getIt<ClientLoginUseCase>(),
      freelancerLoginUseCase: getIt<FreelancerLoginUseCase>(),
      clientDashboardCubit: getIt<ClientDashboardCubit>(),
      freelancerDashboardCubit: getIt<FreelancerDashboardCubit>()));
}

//Join as client/freelancer dependencies
_initJoinAsClientFreelancerDependencies() async {
  getIt.registerFactory<JoinAsClientFreelancerCubit>(() =>
      JoinAsClientFreelancerCubit(
          clientBloc: getIt<ClientBloc>(),
          freelancerBloc: getIt<FreelancerBloc>(),
          loginBloc: getIt<LoginBloc>()));
}

//Splash screen dependencies
_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashScreenCubit>(
      () => SplashScreenCubit(getIt<OnboardScreenCubit>()));
}

//Onboard screen dependencies
_initOnboardScreenDependencies() async {
  getIt.registerFactory<OnboardScreenCubit>(() => OnboardScreenCubit(
      loginBloc: getIt<LoginBloc>(),
      asClientFreelancerCubit: getIt<JoinAsClientFreelancerCubit>(),
      clientBloc: getIt<ClientBloc>(),
      freelancerBloc: getIt<FreelancerBloc>()));
}

//Client dashboard dependencies
_initClientDashboardDependencies() async {
  getIt.registerFactory<ClientDashboardCubit>(() => ClientDashboardCubit());
}

//Freelancer dashboard dependencies
_initFreelancerDashboardDependencies() async {
  getIt.registerFactory<FreelancerDashboardCubit>(
      () => FreelancerDashboardCubit());
}
