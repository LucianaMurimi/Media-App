import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/application/locator.dart';
import 'package:sccult_media/application/network_info.dart';
import 'package:sccult_media/data/firebase/authentication_service.dart';
import 'package:sccult_media/data/firebase/firestore_crud.dart';
import 'package:sccult_media/data/requests/authentication_request.dart';
import 'package:sccult_media/data/responses/failure.dart';
import 'package:sccult_media/data/tables.dart';
import 'package:sccult_media/domain/models/authentication_models.dart';
import 'package:sccult_media/domain/models/user.dart';
import 'package:sccult_media/presentation/resources/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository{
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NetworkInfo _networkInfo = locator<NetworkInfo>();
  final FirestoreCrud _firebaseCrud = FirestoreCrud();

  //----------------------------------------------------------------------------
  //REGISTER
  Future<Either<Failure, AuthenticatedUser>> register(AuthenticateRequest registerRequest, context) async {
    try{
      //register
      UserCredential registerResult = await _authenticationService.registerWithEmailAndPassword(registerRequest.email, registerRequest.password);
      User? user = registerResult.user;

      return Right(AuthenticatedUser(email: user?.email));
    }catch(err){
      return Left(Failure(message: AppLocalizations.of(context)!.registrationError));
    }
  }
  //----------------------------------------------------------------------------
  // LOGIN
  Future<Either<Failure, AuthenticatedUser>> login(AuthenticateRequest loginRequest, context) async {
    final prefs = await SharedPreferences.getInstance();

    //1. check connectivity
    if(await _networkInfo.isConnected){
      try{
        UserCredential _loginResult = await _authenticationService.loginWithEmailAndPassword(loginRequest.email, loginRequest.password);
        User? _user = _loginResult.user;

        await _firebaseCrud.retrieve(Tables.users, "email", _user?.email)
          .then((value) async {
          TUser user = TUser.fromMap(value[0]);

          // TODO: Cache
          await prefs.setString('name', user.name);
          await prefs.setString('email', user.email);
          await prefs.setString('role', user.role);
        });

        return Right(AuthenticatedUser(email: _user?.email));
      }catch(error){
        await prefs.setString('userEmail', '');
        return Left(
            Failure(
                message: AppLocalizations.of(context)!.loginError)
        );
      }
    }else{
      // no internet error
      return Left(
        Failure(
          message: AppLocalizations.of(context)!.tryConnectingToInternet
        ),
      );
    }
  }
  //----------------------------------------------------------------------------
  //LOGOUT
  Future logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    try{
      await _authenticationService.logout().then((value) async {
        await prefs.remove('name');
        await prefs.remove('email');
        await prefs.remove('role');
        Navigator.pushNamed(
            context, Routes.homeRoute);
      });
    }catch(error){
      await prefs.remove('name');
      await prefs.remove('email');
      await prefs.remove('role');
      Navigator.pushNamed(
          context, Routes.homeRoute);
    }
  }
}
