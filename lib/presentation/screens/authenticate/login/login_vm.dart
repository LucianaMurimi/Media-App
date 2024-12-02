import 'package:flutter/material.dart';
import 'package:sccult_media/domain/usecase/authentication_usecase.dart';
import 'package:sccult_media/presentation/helpers/validation_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/presentation/helpers/validators.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'package:sccult_media/presentation/resources/routes_manager.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';


class LoginViewModel extends ChangeNotifier{
  //dependencies
  LoginViewModel(this._loginUseCase);
  LoginUseCase _loginUseCase;

  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //validation models
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);

  //getters
  ValidationModel get email => _email;
  ValidationModel get password => _password;

  //setters
  void setEmail(String value){
    _email = ValidationModel(value, null);
    notifyListeners();
  }

  void setPassword(String value){
    _password = ValidationModel(value, null);
    notifyListeners();
  }

  //validators
  void validateEmail(BuildContext context, String? email){
    Validated _isValid = isEmailValid(email);
    if(_isValid != Validated.valid){
      if(_isValid == Validated.empty){
        _email = ValidationModel(null, AppLocalizations.of(context)!.emailEmptyErrorText);
      } else{
        _email = ValidationModel(null, AppLocalizations.of(context)!.emailErrorText);
      }
    }
    notifyListeners();
  }

  void validatePassword(BuildContext context, String? password){
    if(password == null || password.isEmpty){
      _password = ValidationModel(null, AppLocalizations.of(context)!.passwordEmptyErrorText);
    }
    notifyListeners();
  }

  //login
  Future<void> login(BuildContext context, viewState) async {
    // 1. validate
    validateEmail(context, email.value);
    validatePassword(context, password.value);

    if(email.error == null && password.error == null){
      FocusScope.of(context).unfocus();
      // 2. set loading state
      viewState.setViewState(AppViewState.loading);

      //3. call usecase to prepare login request
      //4. provide login request to repository and await login.
              //handle result -
              //  failure: display error using custom snackbar
              //  success: reset [viewState], navigate to home
      (await _loginUseCase.execute(
        LoginUseCaseInput(email: email.value!.trim(), password: password.value!.trim(), context: context)))
      .fold(
              (failure) {
                viewState.setViewState(AppViewState.content);
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                      message: failure.message),
                );
              },
              (success) async{
                viewState.setViewState(AppViewState.content);
                passwordController.value = TextEditingValue.empty;
                _password = ValidationModel(null, null);

                Navigator.pushReplacementNamed(
                    context, Routes.homeRoute);
                notifyListeners();
              });
    }
  }

  //reset password
  void resetPassword(BuildContext context){
    Navigator.pushNamed(
        context, Routes.resetPasswordRoute);
  }

  //register
  void register(BuildContext context){
    Navigator.pushNamed(
        context, Routes.registerRoute);
  }
}