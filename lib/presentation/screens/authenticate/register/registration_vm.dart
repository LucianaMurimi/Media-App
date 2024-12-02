import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sccult_media/data/requests/authentication_request.dart';
import 'package:sccult_media/data/requests/registration_request.dart';
import 'package:sccult_media/domain/usecase/registration_usecase.dart';
import 'package:sccult_media/presentation/helpers/validation_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/presentation/helpers/validators.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/name.dart';

class RegistrationViewModel with ChangeNotifier{
  //----------------------------------------------------------------------------
  //1. Variable definition - validation models.
  ValidationModel name = ValidationModel(null, null);
  ValidationModel username = ValidationModel(null, null);
  ValidationModel role = ValidationModel(null, null);
  ValidationModel email = ValidationModel(null, null);
  ValidationModel password = ValidationModel(null, null);
  ValidationModel confirmPassword = ValidationModel(null, null);
  ValidationModel profilePicture = ValidationModel(null, null);
  File? profilePictureImage;
  ValidationModel bio = ValidationModel(null, null);
  ValidationModel location = ValidationModel(null, null);

  RegistrationUseCase registrationUseCase;
  //----------------------------------------------------------------------------
  //2. Callback for navigation
  void Function(int)? onPageChange;
  // Constructor to accept the navigation callback
  RegistrationViewModel({this.onPageChange, required this.registrationUseCase});

  //----------------------------------------------------------------------------
  //3. Validation
  validate(BuildContext context, int step) async {
    switch(step){
      case 1:
        if(role.value?.isEmpty ?? true){
          role.error = AppLocalizations.of(context)!.pleaseSelectOption;
        }else{
          role.error = null;
          onPageChange!(1);
        }
        notifyListeners();
        break;
      case 2:
        if(name.value?.isEmpty ?? true){
          name.error = AppLocalizations.of(context)!.cannotBeEmpty;
          if(username.value?.isEmpty ?? true){
            username.error = AppLocalizations.of(context)!.cannotBeEmpty;
          }
        } else{
          name.error = null;
          username.error = null;
          onPageChange!(2);
        }
        notifyListeners();
        break;
      case 3:
        if(profilePictureImage == null){
          break;
        }else{
          onPageChange!(3);
        }
        break;
      case 4:
        if(bio.value?.isEmpty ?? true){
          bio.error = AppLocalizations.of(context)!.cannotBeEmpty;
        }else{
          bio.error = null;
          onPageChange!(4);
        }
        notifyListeners();
        break;
      case 5:
        if(location.value?.isEmpty ?? true){
          location.error = AppLocalizations.of(context)!.cannotBeEmpty;
        }else{
          location.error = null;
          onPageChange!(5);
        }
        notifyListeners();
        break;
      case 6:
        Validated isValid = isEmailValid(email.value);
        if(isValid != Validated.valid){
          if(isValid == Validated.empty){
            email.error = AppLocalizations.of(context)!.emailEmptyErrorText;
          } else{
            email.error =AppLocalizations.of(context)!.emailErrorText;
          }
        }else{
          email.error = null;
          onPageChange!(6);
        }
        notifyListeners();
        break;
      case 7:
        if(password.value == confirmPassword.value){
          Validated isValid = isPasswordValid(password.value);
          if(isValid != Validated.valid){
            if(isValid == Validated.empty){
              password.error = AppLocalizations.of(context)!.passwordEmptyErrorText;
            }else if (isValid == Validated.short){
              password.error = AppLocalizations.of(context)!.weakPasswordErrorText;
            }else{
              password.error =AppLocalizations.of(context)!.passwordErrorText;
            }
          }else{
            password.error = null;
            onPageChange!(6);
          }
        }else{
          password.error =AppLocalizations.of(context)!.passwordErrorText;
        }
        //registration
        await registrationUseCase.execute(
            AuthenticateRequest(email: email.value!.trim(), password: password.value!.trim()),
            [profilePictureImage!],
            RegistrationRequest(name: name.value, username: username.value, role: role.value, email: email.value, profilePicture: '', bio: bio.value, location: location.value),
            context);
        notifyListeners();
    }
  }
}