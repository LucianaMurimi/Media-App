import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sccult_media/application/network_info.dart';
import 'package:sccult_media/data/firebase/authentication_service.dart';
import 'package:sccult_media/domain/repository/authentication_repository.dart';
import 'package:sccult_media/domain/repository/registration_repository.dart';
import 'package:sccult_media/domain/usecase/authentication_usecase.dart';
import 'package:sccult_media/domain/usecase/registration_usecase.dart';

final locator = GetIt.instance;

setUpLocator(){
  //AuthenticationService
  if(!locator.isRegistered<AuthenticationService>()) {
    locator.registerLazySingleton(() => AuthenticationService());
  }

  //AuthenticationRepository
  if(!locator.isRegistered<AuthenticationRepository>()) {
    locator.registerLazySingleton(() => AuthenticationRepository());
  }

  //RegistrationRepository
  if(!locator.isRegistered<RegistrationRepository>()) {
    locator.registerLazySingleton(() => RegistrationRepository());
  }

  //NetworkInfo
  if(!locator.isRegistered<NetworkInfo>()) {
    locator.registerLazySingleton<NetworkInfo>(
            () => NetworkInfoImpl(InternetConnectionChecker()));
  }

  //LoginUseCase
  if(!locator.isRegistered<LoginUseCase>()) {
    locator.registerFactory<LoginUseCase>(
            () => LoginUseCase(locator<AuthenticationRepository>()));
  }

  if(!locator.isRegistered<LogoutUseCase>()) {
    locator.registerFactory<LogoutUseCase>(
            () => LogoutUseCase(locator<AuthenticationRepository>()));
  }

  if(!locator.isRegistered<RegistrationUseCase>()) {
    locator.registerFactory<RegistrationUseCase>(
            () => RegistrationUseCase(locator<AuthenticationRepository>(),
                locator<RegistrationRepository>()));
  }
}