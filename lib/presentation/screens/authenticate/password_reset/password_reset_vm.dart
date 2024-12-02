import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/application/locator.dart';
import 'package:sccult_media/domain/repository/authentication_repository.dart';
import 'package:sccult_media/presentation/helpers/validation_model.dart';
import 'package:sccult_media/presentation/helpers/validators.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';

class PasswordResetViewModel extends ChangeNotifier{
  ValidationModel _email = ValidationModel(null, null);

  ValidationModel get email => _email;
  set email (ValidationModel model) {_email = model;}

  validateEmail(BuildContext context){
    Validated _isValid = isEmailValid(_email.value);

    if(_isValid != Validated.valid){
      if(_isValid == Validated.empty){
        _email = ValidationModel(null, AppLocalizations.of(context)!.emailEmptyErrorText);
      } else{
        _email = ValidationModel(null, AppLocalizations.of(context)!.emailErrorText);
      }
    }
    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context, ViewState viewState) async {

  }

  void showHelpDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(16.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text("${AppLocalizations.of(context)!.passwordResetProcess}:", textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: ColorManager.white),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16,),
                      Text("1.  ${AppLocalizations.of(context)!.passwordResetProcess1}. \n \n 2. ${AppLocalizations.of(context)!.passwordResetProcess2}. \n \n3. ${AppLocalizations.of(context)!.passwordResetProcess3}. \n \n4. ${AppLocalizations.of(context)!.passwordResetProcess4}",
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 16,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomAppButton(
                            label: AppLocalizations.of(context)!.continueStr,
                            onPressed: (){Navigator.pop(context, true);},
                            width: 136,
                            isPrimary: true),
                      ),
                      const SizedBox(height: 24,),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}