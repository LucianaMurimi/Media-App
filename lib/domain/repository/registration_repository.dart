import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/application/locator.dart';
import 'package:sccult_media/application/network_info.dart';
import 'package:sccult_media/data/firebase/firestore_crud.dart';
import 'package:sccult_media/data/requests/registration_request.dart';
import 'package:sccult_media/data/responses/failure.dart';
import 'package:sccult_media/data/tables.dart';
import 'package:sccult_media/domain/models/authentication_models.dart';
import 'package:sccult_media/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRepository{
  final NetworkInfo _networkInfo = locator<NetworkInfo>();
  final FirestoreCrud _firebaseCrud = FirestoreCrud();

  Future<Either<Failure, AuthenticatedUser>> register(RegistrationRequest registrationRequest, context) async {
    final prefs = await SharedPreferences.getInstance();
    late AuthenticatedUser authenticatedUser;

    try{
      //1. post registration info => [users]
      await _firebaseCrud.create(Tables.users, true, registrationRequest.toMap())
          .then((_) => authenticatedUser = AuthenticatedUser(email: registrationRequest.email));
      return Right(authenticatedUser);

    }catch(err){
      //2. registration unsuccessful
      return Left(
          Failure(message: AppLocalizations.of(context)!.registrationError)
      );
    }
  }

  Future<Either<Failure, String>> uploadProfilePicture(List<File> images, String emailId, context) async {
    String profilePictureUrl = '';
    try{
      //1. upload picture
      await _firebaseCrud.uploadImages(Tables.images, images, emailId)
          .then((value) => profilePictureUrl = value[0]);
      return Right(profilePictureUrl);

    }catch(err){
      //2. profile picture upload unsuccessful
      return Left(
          Failure(message: AppLocalizations.of(context)!.registrationError)
      );
    }
  }
}