import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sccult_media/data/requests/authentication_request.dart';
import 'package:sccult_media/data/responses/failure.dart';
import 'package:sccult_media/domain/models/authentication_models.dart';
import 'package:sccult_media/domain/repository/authentication_repository.dart';


class LoginUseCaseInput {
  String email;
  String password;
  BuildContext context;

  LoginUseCaseInput({required this.email, required this.password, required this.context});
}

class LoginUseCase{
  LoginUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  Future<Either<Failure, AuthenticatedUser>> execute(LoginUseCaseInput input){
    // Future execute(LoginUseCaseInput input){

    // prepare request
    // make request
    return _authenticationRepository.login(
        AuthenticateRequest(email: input.email, password: input.password), input.context);
  }
}


class LogoutUseCaseInput {
  BuildContext context;

  LogoutUseCaseInput({required this.context});
}

class LogoutUseCase{
  LogoutUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  execute(LogoutUseCaseInput input){
    return _authenticationRepository.logout(input.context);
  }
}