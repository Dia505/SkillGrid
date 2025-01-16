import 'package:get_it/get_it.dart';
import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/auth/data/data_source/local_data_source/client_local_data_source.dart';
import 'package:skill_grid/features/auth/data/repository/client_local_repository.dart';
import 'package:skill_grid/features/auth/domain/use_case/delete_client_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/register_client_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';

final getIt = GetIt.instance;

Future<void> intiDependencies() async {
  await _initHiveService();
  await _initClientRegistrationDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initClientRegistrationDependencies() async {
  getIt.registerLazySingleton<ClientLocalDataSource>(
    () => ClientLocalDataSource(hiveService: getIt())
  );

  getIt.registerLazySingleton<ClientLocalRepository>(() => 
    ClientLocalRepository(clientLocalDataSource: getIt<ClientLocalDataSource>())
  );

  getIt.registerLazySingleton<RegisterClientUseCase>(
    () => RegisterClientUseCase(clientRepository: getIt<ClientLocalRepository>())
  );

  getIt.registerLazySingleton<DeleteClientUseCase>(
    () => DeleteClientUseCase(clientRepository: getIt<ClientLocalRepository>())
  );

  getIt.registerLazySingleton<GetClientByIdUseCase>(
    () => GetClientByIdUseCase(clientRepository: getIt<ClientLocalRepository>())
  );

  getIt.registerFactory<ClientBloc>(() => 
    ClientBloc(registerClientUseCase: getIt<RegisterClientUseCase>())
  );
}