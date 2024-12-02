import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/helpers/validation_model.dart';
import 'package:sccult_media/presentation/resources/assets_manager.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/password_reset/password_reset_vm.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PasswordResetViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6750A4),
          iconTheme: const IconThemeData(color: Color(0xFFffffff)),
          elevation: 2.0,

          toolbarHeight: 96.0,

          titleSpacing: 0,

          automaticallyImplyLeading: true,

          title: Text(AppLocalizations.of(context)!.resetPasswd,
              style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.white, fontSize: 20.0)),
          actions: [
            IconButton(onPressed: (){setState(() {
              viewModel.showHelpDialog(context);
            });}, icon: const Icon(Icons.help_rounded, size: 28,),),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(onPressed: (){setState(() {
                Navigator.of(context).pop();
              });}, icon: const Icon(Icons.clear, size: 28,),),
            )],
        ),
        body: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32.0, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(AppLocalizations.of(context)!.providePasswordResetEmail),
                  const SizedBox(height: 24),
                  TextFormField(
                    onChanged: (val){viewModel.email = ValidationModel(val, null);},
                    validator: (_){return viewModel.email.error;},

                    autovalidateMode: AutovalidateMode.always,

                    keyboardType: TextInputType.emailAddress,
                    cursorColor: const Color(0x80323232),
                    decoration: CustomInputDecoration.textFormFieldStyle(
                      prefixIcon: const Icon(Icons.email, color: Color(0xB3000000), size: 18,),
                      labelText: AppLocalizations.of(context)!.email,
                      hintText: AppLocalizations.of(context)!.emailHintText,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                        width: double.infinity,
                        decoration: CustomButtonDecoration.buttonDecorationStyle(true),

                        child: TextButton(
                          child: Text(AppLocalizations.of(context)!.resetPasswd, style: const TextStyle(fontFamily: 'Poppins-bold', letterSpacing: 1.2, color: Color(0xFFffffff))),
                          onPressed: () {
                            //TODO: resetPassword
                            // _viewModel.resetPassword(context, _viewState);
                          },),),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.arrow_circle_right_rounded, size: 28, color: ColorManager.white),
                          ),),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
