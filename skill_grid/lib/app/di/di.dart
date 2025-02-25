import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/core/network/api_service.dart';
import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/data/data_source/local_data_source/appointment_local_data_source.dart';
import 'package:skill_grid/features/appointment/data/data_source/remote_data_source/appointment_remote_data_source.dart';
import 'package:skill_grid/features/appointment/data/repository/local_repository/appointment_local_repository.dart';
import 'package:skill_grid/features/appointment/data/repository/remote_repository/appointment_remote_repository.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_id_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/save_appointment_use_case.dart';
import 'package:skill_grid/features/appointment/domain/use_case/update_appointment_use_case.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/billing_and_payment/billing_and_payment_bloc.dart';
import 'package:skill_grid/features/appointment/presentation/view_model/send_an_offer/send_an_offer_bloc.dart';
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
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/reset_password_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/send_otp_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_profile_picture_usecase.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/verify_otp_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/delete_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/freelancer_login_usec_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_all_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/get_freelancer_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/register_freelancer_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_cubit.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/reset_password/reset_password_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/send_otp/send_otp_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/freelancer/freelancer_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/verify_otp/verify_otp_bloc.dart';
import 'package:skill_grid/features/billing_address/data/data_source/remote_data_source.dart/billing_address_remote_data_source.dart';
import 'package:skill_grid/features/billing_address/data/repository/remote_repository/billing_address_remote_repository.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/get_billing_address_by_id_use_case.dart';
import 'package:skill_grid/features/billing_address/domain/use_case/save_billing_address_use_case.dart';
import 'package:skill_grid/features/education/data/data_source/local_data_source/education_local_data_source.dart';
import 'package:skill_grid/features/education/data/data_source/remote_data_source/education_remote_data_source.dart';
import 'package:skill_grid/features/education/data/repository/local_repository/education_local_repository.dart';
import 'package:skill_grid/features/education/data/repository/remote_repository/education_remote_repository.dart';
import 'package:skill_grid/features/education/domain/use_case/get_education_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/employment/data/data_source/local_data_source/employment_local_data_source.dart';
import 'package:skill_grid/features/employment/data/data_source/remote_data_source/employment_remote_data_source.dart';
import 'package:skill_grid/features/employment/data/repository/local_repository/employment_local_repository.dart';
import 'package:skill_grid/features/employment/data/repository/remote_repository/employment_remote_repository.dart';
import 'package:skill_grid/features/employment/domain/use_case/get_employment_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/freelancer_service/data/data_source/local_data_source/freelancer_service_local_data_source.dart';
import 'package:skill_grid/features/freelancer_service/data/data_source/remote_data_source/freelancer_service_remote_data_source.dart';
import 'package:skill_grid/features/freelancer_service/data/repository/local_repository/freelancer_service_local_repository.dart';
import 'package:skill_grid/features/freelancer_service/data/repository/remote_repository/freelancer_service_remote_repository.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/edit_delete_contract/edit_delete_contract_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/search_screen/search_bloc.dart';
import 'package:skill_grid/features/payment/data/data_source/local_data_source/payment_local_data_source.dart';
import 'package:skill_grid/features/payment/data/data_source/remote_data_source/payment_remote_data_source.dart';
import 'package:skill_grid/features/payment/data/repository/local_repository/payment_local_repository.dart';
import 'package:skill_grid/features/payment/data/repository/remote_repository/payment_remote_repository.dart';
import 'package:skill_grid/features/payment/domain/use_case/delete_payment_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/payment/domain/use_case/get_payment_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/payment/domain/use_case/save_payment_use_case.dart';
import 'package:skill_grid/features/payment/domain/use_case/update_payment_use_case.dart';
import 'package:skill_grid/features/portfolio/data/data_source/local_data_source/portfolio_local_data_source.dart';
import 'package:skill_grid/features/portfolio/data/data_source/remote_data_source/portfolio_remote_data_source.dart';
import 'package:skill_grid/features/portfolio/data/repository/local_repository/portfolio_local_repository.dart';
import 'package:skill_grid/features/portfolio/data/repository/remote_repository/portfolio_remote_repository.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/edit_profile/client_edit_profile_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/client/client_profile_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';
import 'package:skill_grid/features/review/data/data_source/local_data_source/review_local_data_source.dart';
import 'package:skill_grid/features/review/data/data_source/remote_data_source/review_remote_data_source.dart';
import 'package:skill_grid/features/review/data/repository/local_repository/review_local_repository.dart';
import 'package:skill_grid/features/review/data/repository/remote_repository/review_remote_repository.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_appointment_id_use_case.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_rating_use_case.dart';
import 'package:skill_grid/features/review/domain/use_case/save_review_use_case.dart';
import 'package:skill_grid/features/review/presentation/view_model/review_bloc.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/onboard_screen/onboard_screen_cubit.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/splash_screen/splash_screen_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initTokenHelper();

  await _initClientRegistrationDependencies();
  await _initFreelancerRegistrationDependencies();
  await _initLoginDependencies();
  await _initJoinAsClientFreelancerDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardScreenDependencies();
  await _initClientDashboardDependencies();
  await _initClientHomeScreenDependencies();
  await _initClientProfileDependencies();
  await _initEditClientProfileDependencies();
  await _initFreelancerServiceDependencies();
  await _initPortfolioDependencies();
  await _initSearchFreelancersDependencies();
  await _initReviewDependencies();
  await _initFreelancerProfileDependencies();
  await _initEducationDependencies();
  await _initEmploymentDependencies();
  await _initAppointmentDependencies();
  await _initSendAnOfferDependencies();
  await _initBillingAndPaymentDependencies();
  await _initPaymentDependencies();
  await _initBillingAddressDependencies();
  await _initClientContractsDependencies();
  await _initEditDeleteContractDependencies();
  await _initSendOtpDependencies();
  await _initVerifyOtpDependencies();
  await _initResetPasswordDependencies();
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

_initTokenHelper() {
  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<TokenHelper>(
      () => TokenHelper(tokenSharedPrefs: getIt<TokenSharedPrefs>()));
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

  getIt.registerLazySingleton<DeleteClientUseCase>(() => DeleteClientUseCase(
        clientRepository: getIt<ClientLocalRepository>(),
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      ));

  getIt.registerLazySingleton<GetClientByIdUseCase>(() => GetClientByIdUseCase(
      clientRepository: getIt<ClientRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      tokenHelper: getIt<TokenHelper>()));

  getIt.registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(
    clientRepository: getIt<ClientRemoteRepository>(),
  ));
  getIt.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(
    clientRepository: getIt<ClientRemoteRepository>(),
  ));
  getIt.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(
    clientRepository: getIt<ClientRemoteRepository>(),
  ));

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
          freelancerRepository: getIt<FreelancerRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));

  getIt.registerLazySingleton<GetAllFreelancerUseCase>(() =>
      GetAllFreelancerUseCase(
          freelancerRepository: getIt<FreelancerLocalRepository>()));

  getIt.registerFactory<FreelancerBloc>(() => FreelancerBloc(
      registerFreelancerUseCase: getIt<RegisterFreelancerUseCase>(),
      loginBloc: getIt<LoginBloc>()));
}

//Login dependencies
_initLoginDependencies() async {
  getIt.registerLazySingleton<ClientLoginUseCase>(() => ClientLoginUseCase(
      getIt<ClientRemoteRepository>(), getIt<TokenSharedPrefs>()));

  getIt.registerLazySingleton<FreelancerLoginUseCase>(
      () => FreelancerLoginUseCase(getIt<FreelancerRemoteRepository>()));

  getIt.registerFactory<LoginBloc>(() => LoginBloc(
      clientLoginUseCase: getIt<ClientLoginUseCase>(),
      clientDashboardCubit: getIt<ClientDashboardCubit>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>()));
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
  getIt.registerFactory<SplashScreenCubit>(() => SplashScreenCubit(
      getIt<OnboardScreenCubit>(), getIt<ClientDashboardCubit>()));
}

//Onboard screen dependencies
_initOnboardScreenDependencies() async {
  getIt.registerFactory<OnboardScreenCubit>(() => OnboardScreenCubit(
      loginBloc: getIt<LoginBloc>(), clientBloc: getIt<ClientBloc>()));
}

//Client dashboard dependencies
_initClientDashboardDependencies() async {
  getIt.registerFactory<ClientDashboardCubit>(() => ClientDashboardCubit());
}

//Client home screen dependencies
_initClientHomeScreenDependencies() async {
  getIt.registerFactory<ClientHomeBloc>(() => ClientHomeBloc(
      getClientByIdUseCase: getIt<GetClientByIdUseCase>(),
      tokenHelper: getIt<TokenHelper>(),
      searchFreelancersUseCase: getIt<SearchFreelancersUseCase>(),
      getAppointmentByClientIdUseCase: getIt<GetAppointmentByClientIdUseCase>()));
}

//Edit client profile dependencies
_initEditClientProfileDependencies() async {
  getIt.registerLazySingleton<UpdateClientProfilePictureUsecase>(() =>
      UpdateClientProfilePictureUsecase(
          clientRepository: getIt<ClientRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          tokenHelper: getIt<TokenHelper>()));

  getIt.registerLazySingleton<UpdateClientUseCase>(() => UpdateClientUseCase(
      clientRepository: getIt<ClientRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      tokenHelper: getIt<TokenHelper>()));

  getIt.registerFactory<ClientEditProfileBloc>(() => ClientEditProfileBloc(
      getClientByIdUseCase: getIt<GetClientByIdUseCase>(),
      tokenHelper: getIt<TokenHelper>(),
      updateClientProfilePictureUsecase:
          getIt<UpdateClientProfilePictureUsecase>(),
      updateClientUseCase: getIt<UpdateClientUseCase>()));
}

//Client profile dependencies
_initClientProfileDependencies() async {
  getIt.registerFactory<ClientProfileBloc>(() => ClientProfileBloc(
      getClientByIdUseCase: getIt<GetClientByIdUseCase>(),
      tokenHelper: getIt<TokenHelper>(),
      clientEditProfileBloc: getIt<ClientEditProfileBloc>()));
}

//Freelancer Service dependencies
_initFreelancerServiceDependencies() async {
  getIt.registerLazySingleton<FreelancerServiceLocalDataSource>(
      () => FreelancerServiceLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<FreelancerServiceRemoteDataSource>(
      () => FreelancerServiceRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<FreelancerServiceLocalRepository>(() =>
      FreelancerServiceLocalRepository(
          freelancerServiceLocalDataSource:
              getIt<FreelancerServiceLocalDataSource>()));
  getIt.registerLazySingleton<FreelancerServiceRemoteRepository>(() =>
      FreelancerServiceRemoteRepository(
          freelancerServiceRemoteDataSource:
              getIt<FreelancerServiceRemoteDataSource>()));

  getIt.registerLazySingleton<GetFreelancerServiceByFreelancerIdUseCase>(() =>
      GetFreelancerServiceByFreelancerIdUseCase(
          freelancerServiceRepository:
              getIt<FreelancerServiceRemoteRepository>()));
}

//Portfolio dependencies
_initPortfolioDependencies() async {
  getIt.registerLazySingleton<PortfolioLocalDataSource>(
      () => PortfolioLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<PortfolioRemoteDataSource>(
      () => PortfolioRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<PortfolioLocalRepository>(() =>
      PortfolioLocalRepository(
          portfolioLocalDataSource: getIt<PortfolioLocalDataSource>()));
  getIt.registerLazySingleton<PortfolioRemoteRepository>(() =>
      PortfolioRemoteRepository(
          portfolioRemoteDataSource: getIt<PortfolioRemoteDataSource>()));

  getIt.registerLazySingleton<GetPortfolioByFreelancerIdUseCase>(() =>
      GetPortfolioByFreelancerIdUseCase(
          portfolioRepository: getIt<PortfolioRemoteRepository>()));

  getIt.registerLazySingleton<GetPortfolioByFreelancerServiceIdUseCase>(() =>
      GetPortfolioByFreelancerServiceIdUseCase(
          portfolioRepository: getIt<PortfolioRemoteRepository>()));
}

//Review dependencies
_initReviewDependencies() async {
  getIt.registerLazySingleton<ReviewLocalDataSource>(
      () => ReviewLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<ReviewRemoteDataSource>(
      () => ReviewRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<ReviewLocalRepository>(() =>
      ReviewLocalRepository(
          reviewLocalDataSource: getIt<ReviewLocalDataSource>()));
  getIt.registerLazySingleton<ReviewRemoteRepository>(() =>
      ReviewRemoteRepository(
          reviewRemoteDataSource: getIt<ReviewRemoteDataSource>()));

  getIt.registerLazySingleton<GetReviewByFreelancerIdUseCase>(() =>
      GetReviewByFreelancerIdUseCase(
          reviewRepository: getIt<ReviewRemoteRepository>()));
  getIt.registerLazySingleton<GetReviewByRatingUseCase>(() =>
      GetReviewByRatingUseCase(
          reviewRepository: getIt<ReviewRemoteRepository>()));
  getIt.registerLazySingleton<SaveReviewUseCase>(() => SaveReviewUseCase(
      reviewRepository: getIt<ReviewRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      tokenHelper: getIt<TokenHelper>()));
  getIt.registerLazySingleton<GetReviewByAppointmentIdUseCase>(() => GetReviewByAppointmentIdUseCase(
      reviewRepository: getIt<ReviewRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>()));

  getIt.registerFactory<ReviewBloc>(() => ReviewBloc(
      saveReviewUseCase: getIt<SaveReviewUseCase>(),
      tokenHelper: getIt<TokenHelper>(),
      getClientByIdUseCase: getIt<GetClientByIdUseCase>()));
}

//Search screen dependencies
_initSearchFreelancersDependencies() async {
  getIt.registerLazySingleton<SearchFreelancersUseCase>(() =>
      SearchFreelancersUseCase(
          freelancerRepository: getIt<FreelancerRemoteRepository>()));

  getIt.registerFactory<SearchBloc>(() => SearchBloc(
      searchFreelancersUseCase: getIt<SearchFreelancersUseCase>(),
      getPortfolioByFreelancerServiceIdUseCase:
          getIt<GetPortfolioByFreelancerServiceIdUseCase>(),
      getFreelancerSerivceByFreelancerIdUseCase:
          getIt<GetFreelancerServiceByFreelancerIdUseCase>(),
      getReviewByFreelancerIdUseCase: getIt<GetReviewByFreelancerIdUseCase>(),
      freelancerProfileBloc: getIt<FreelancerProfileBloc>()));
}

//Education dependencies
_initEducationDependencies() async {
  getIt.registerLazySingleton<EducationLocalDataSource>(
      () => EducationLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<EducationRemoteDataSource>(
      () => EducationRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<EducationLocalRepository>(() =>
      EducationLocalRepository(
          educationLocalDataSource: getIt<EducationLocalDataSource>()));
  getIt.registerLazySingleton<EducationRemoteRepository>(() =>
      EducationRemoteRepository(
          educationRemoteDataSource: getIt<EducationRemoteDataSource>()));

  getIt.registerLazySingleton<GetEducationByFreelancerIdUseCase>(() =>
      GetEducationByFreelancerIdUseCase(
          educationRepository: getIt<EducationRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
}

//Employment dependencies
_initEmploymentDependencies() async {
  getIt.registerLazySingleton<EmploymentLocalDataSource>(
      () => EmploymentLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<EmploymentRemoteDataSource>(
      () => EmploymentRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<EmploymentLocalRepository>(() =>
      EmploymentLocalRepository(
          employmentLocalDataSource: getIt<EmploymentLocalDataSource>()));
  getIt.registerLazySingleton<EmploymentRemoteRepository>(() =>
      EmploymentRemoteRepository(
          employmentRemoteDataSource: getIt<EmploymentRemoteDataSource>()));

  getIt.registerLazySingleton<GetEmploymentByFreelancerIdUseCase>(() =>
      GetEmploymentByFreelancerIdUseCase(
          employmentRepository: getIt<EmploymentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
}

//Appointment dependencies
_initAppointmentDependencies() {
  getIt.registerLazySingleton<AppointmentLocalDataSource>(
      () => AppointmentLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<AppointmentLocalRepository>(() =>
      AppointmentLocalRepository(
          appointmentLocalDataSource: getIt<AppointmentLocalDataSource>()));
  getIt.registerLazySingleton<AppointmentRemoteRepository>(() =>
      AppointmentRemoteRepository(
          appointmentRemoteDataSource: getIt<AppointmentRemoteDataSource>()));

  getIt.registerLazySingleton<GetAppointmentByFreelancerIdUseCase>(() =>
      GetAppointmentByFreelancerIdUseCase(
          appointmentRepository: getIt<AppointmentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
  getIt.registerLazySingleton<SaveAppointmentUseCase>(() =>
      SaveAppointmentUseCase(
          appointmentRepository: getIt<AppointmentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          tokenHelper: getIt<TokenHelper>()));
  getIt.registerLazySingleton<GetAppointmentByIdUseCase>(() =>
      GetAppointmentByIdUseCase(
          appointmentRepository: getIt<AppointmentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
  getIt.registerLazySingleton<GetAppointmentByClientIdUseCase>(() =>
      GetAppointmentByClientIdUseCase(
          appointmentRepository: getIt<AppointmentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          tokenHelper: getIt<TokenHelper>()));
  getIt.registerLazySingleton<UpdateAppointmentUseCase>(() =>
      UpdateAppointmentUseCase(
          appointmentRepository: getIt<AppointmentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          tokenHelper: getIt<TokenHelper>()));
}

//Send an offer dependencies
_initSendAnOfferDependencies() async {
  getIt.registerFactory<SendAnOfferBloc>(() => SendAnOfferBloc(
      getFreelancerByIdUseCase: getIt<GetFreelancerByIdUseCase>(),
      getFreelancerServiceByFreelancerIdUseCase:
          getIt<GetFreelancerServiceByFreelancerIdUseCase>(),
      tokenHelper: getIt<TokenHelper>(),
      getClientByIdUseCase: getIt<GetClientByIdUseCase>()));
}

//Freelancer profile screen dependencies
_initFreelancerProfileDependencies() async {
  getIt.registerFactory<FreelancerProfileBloc>(() => FreelancerProfileBloc(
      getFreelancerByIdUseCase: getIt<GetFreelancerByIdUseCase>(),
      getFreelancerServiceByFreelancerIdUseCase:
          getIt<GetFreelancerServiceByFreelancerIdUseCase>(),
      getReviewByFreelancerIdUseCase: getIt<GetReviewByFreelancerIdUseCase>(),
      getPortfolioByFreelancerServiceIdUseCase:
          getIt<GetPortfolioByFreelancerServiceIdUseCase>(),
      getEducationByFreelancerIdUseCase:
          getIt<GetEducationByFreelancerIdUseCase>(),
      getEmploymentByFreelancerIdUseCase:
          getIt<GetEmploymentByFreelancerIdUseCase>(),
      getAppointmentByFreelancerIdUseCase:
          getIt<GetAppointmentByFreelancerIdUseCase>(),
      sendAnOfferBloc: getIt<SendAnOfferBloc>()));
}

//Payment dependencies
_initPaymentDependencies() async {
  getIt.registerLazySingleton<PaymentLocalDataSource>(
      () => PaymentLocalDataSource(hiveService: getIt()));
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<PaymentLocalRepository>(() =>
      PaymentLocalRepository(
          paymentLocalDataSource: getIt<PaymentLocalDataSource>()));
  getIt.registerLazySingleton<PaymentRemoteRepository>(() =>
      PaymentRemoteRepository(
          paymentRemoteDataSource: getIt<PaymentRemoteDataSource>()));

  getIt.registerLazySingleton<SavePaymentUseCase>(() =>
      SavePaymentUseCase(paymentRepository: getIt<PaymentRemoteRepository>()));
  getIt.registerLazySingleton<GetPaymentByAppointmentIdUseCase>(() =>
      GetPaymentByAppointmentIdUseCase(
          paymentRepository: getIt<PaymentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
  getIt.registerLazySingleton<UpdatePaymentUseCase>(() => UpdatePaymentUseCase(
      paymentRepository: getIt<PaymentRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      tokenHelper: getIt<TokenHelper>()));
  getIt.registerLazySingleton<DeletePaymentByAppointmentIdUseCase>(() =>
      DeletePaymentByAppointmentIdUseCase(
          paymentRepository: getIt<PaymentRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          tokenHelper: getIt<TokenHelper>()));
}

//Billing address dependencies
_initBillingAddressDependencies() async {
  getIt.registerLazySingleton<BillingAddressRemoteDataSource>(
      () => BillingAddressRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<BillingAddressRemoteRepository>(() =>
      BillingAddressRemoteRepository(
          billingAddressRemoteDataSource:
              getIt<BillingAddressRemoteDataSource>()));

  getIt.registerLazySingleton<SaveBillingAddressUseCase>(() =>
      SaveBillingAddressUseCase(
          billlingAddressRepository: getIt<BillingAddressRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>(),
          tokenHelper: getIt<TokenHelper>()));
  getIt.registerLazySingleton<GetBillingAddressByIdUseCase>(() =>
      GetBillingAddressByIdUseCase(
          billingAddressRepository: getIt<BillingAddressRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
}

//Billing and payment dependencies
_initBillingAndPaymentDependencies() async {
  getIt.registerFactory<BillingAndPaymentBloc>(() => BillingAndPaymentBloc(
      saveAppointmentUseCase: getIt<SaveAppointmentUseCase>(),
      saveBillingAddressUseCase: getIt<SaveBillingAddressUseCase>(),
      savePaymentUseCase: getIt<SavePaymentUseCase>(),
      getAppointmentByIdUseCase: getIt<GetAppointmentByIdUseCase>(),
      getBillingAddressByIdUseCase: getIt<GetBillingAddressByIdUseCase>()));
}

//Client contracts dependencies
_initClientContractsDependencies() async {
  getIt.registerFactory<ContractsBloc>(() => ContractsBloc(
      getAppointmentByClientIdUseCase: getIt<GetAppointmentByClientIdUseCase>(),
      tokenHelper: getIt<TokenHelper>(),
      getPaymentByAppointmentIdUseCase:
          getIt<GetPaymentByAppointmentIdUseCase>()));
}

//Edit delete contract dependencies
_initEditDeleteContractDependencies() async {
  getIt.registerFactory<EditDeleteContractBloc>(() => EditDeleteContractBloc(
      updateAppointmentUseCase: getIt<UpdateAppointmentUseCase>(),
      updatePaymentUseCase: getIt<UpdatePaymentUseCase>(),
      deletePaymentByAppointmentIdUseCase:
          getIt<DeletePaymentByAppointmentIdUseCase>(),
      getReviewByAppointmentIdUseCase: getIt<GetReviewByAppointmentIdUseCase>()));
}

//Reset password dependencies
_initResetPasswordDependencies() async {
  getIt.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(
    resetPasswordUseCase: getIt<ResetPasswordUseCase>()
  ));
}

//Verify otp dependencies
_initVerifyOtpDependencies() async {
  getIt.registerFactory<VerifyOtpBloc>(() => VerifyOtpBloc(
    verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
    resetPasswordBloc: getIt<ResetPasswordBloc>()
  ));
}

//Send otp dependencies
_initSendOtpDependencies() async {
  getIt.registerFactory<SendOtpBloc>(() => SendOtpBloc(
    sendOtpUseCase: getIt<SendOtpUseCase>(), 
    verifyOtpBloc: getIt<VerifyOtpBloc>()
  ));
}
