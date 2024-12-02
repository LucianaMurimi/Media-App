import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sccult_media/data/requests/authentication_request.dart';
import 'package:sccult_media/data/requests/registration_request.dart';
import 'package:sccult_media/data/responses/failure.dart';
import 'package:sccult_media/data/responses/success.dart';
import 'package:sccult_media/domain/models/authentication_models.dart';
import 'package:sccult_media/domain/repository/authentication_repository.dart';
import 'package:sccult_media/domain/repository/registration_repository.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';

class RegistrationUseCase {
  RegistrationUseCase(this._authenticationRepository, this._registrationRepository);

  final AuthenticationRepository _authenticationRepository;
  final RegistrationRepository _registrationRepository;

  Future<Either<Failure, Success>> execute(
      AuthenticateRequest registerRequest,
      List<File> images,
      RegistrationRequest registrationRequest,
      context
      )async{

    //1. register with email and password
    //2. upload profile picture
    //3. post registration details

    //Variables
    String profilePictureUrl = '';
    AuthenticatedUser authenticatedUser;

    try{

      // viewState.setViewState(AppViewState.loading);

      //1. register with email and password
      final Either<Failure, AuthenticatedUser> registrationResult = await _authenticationRepository.register(registerRequest, context);

      registrationResult.fold(
        (failure) => null,
        (success) async {
          //2. if registration success => upload profile picture
          final Either<Failure, String> uploadProfilePictureResult = await _registrationRepository.uploadProfilePicture(
            images,
            registerRequest.email!,
            context,
          );
          uploadProfilePictureResult.fold(
              (failure){},
              (success){
                profilePictureUrl = success;
          });

          //3. assign profile picture url
          registrationRequest.profilePicture = profilePictureUrl;

          //4. post registration details
          final Either<Failure, AuthenticatedUser> postRegistrationResult = await _registrationRepository.register(registrationRequest, context);
          postRegistrationResult.fold(
              (failure) => null,
              (success) => Right(Success(message: '')));
        });
      // viewState.setViewState(AppViewState.content);
      return Left(Failure(message: ""));
    }catch(err){
      // viewState.setViewState(AppViewState.content);
      return Left(Failure(message: ""));
    }
  }
}