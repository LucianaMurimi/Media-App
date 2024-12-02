import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/shared_components/progress_dots.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';


class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> with AutomaticKeepAliveClientMixin{
  int pageNumber = 6;
  int pages = 7;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    final viewState = Provider.of<ViewState>(context);
    final RegistrationViewModel registrationViewModel = Provider.of<RegistrationViewModel>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
          child: Column(
            children: [
              const SizedBox(height: 52,),
              // password
              TextFormField(
                controller: _passwordController,
                onChanged: (val)=>registrationViewModel.password.value = val,
                validator: (_){return registrationViewModel.password.error;},
                autovalidateMode: AutovalidateMode.always,

                obscureText: obscurePassword1 ? true : false,
                cursorColor: const Color(0x80323232),
                decoration: CustomizedInputDecoration.textFormFieldStyle(
                  prefixIcon: IconButton(
                    onPressed: (){setState(() {obscurePassword1 = !obscurePassword1;});},
                    icon: obscurePassword1 ? const Icon(Icons.visibility_off, color: Color(0xB3000000), size: 18,)
                        : const Icon(Icons.visibility, color: Color(0xB3000000), size: 18,),
                  ),
                  labelText: AppLocalizations.of(context)!.password,
                  hintText: AppLocalizations.of(context)!.passwordHintText,
                )
              ),
              const SizedBox(height: 16,),
              TextFormField(
                  controller: _confirmPasswordController,
                  onChanged: (val)=>registrationViewModel.confirmPassword.value = val,
                  validator: (_){return registrationViewModel.confirmPassword.error;},
                  autovalidateMode: AutovalidateMode.always,

                  obscureText: obscurePassword2 ? true : false,
                  cursorColor: const Color(0x80323232),
                  decoration: CustomizedInputDecoration.textFormFieldStyle(
                    prefixIcon: IconButton(
                      onPressed: (){setState(() {obscurePassword2 = !obscurePassword2;});},
                      icon: obscurePassword2 ? const Icon(Icons.visibility_off, color: Color(0xB3000000), size: 18,)
                          : const Icon(Icons.visibility, color: Color(0xB3000000), size: 18,),
                    ),
                    labelText: AppLocalizations.of(context)!.confirmPassword,
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                  )
              ),
              const SizedBox(height: 24,),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    width: double.infinity,
                    decoration: CustomButtonDecoration.buttonDecorationStyle(true),

                    child: TextButton(
                      child: viewState.appViewState == AppViewState.loading ? CircularProgressIndicator(color: ColorManager.white,) :
                      Text(AppLocalizations.of(context)!.registerLink, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, letterSpacing: 1.4, color: Color(0xFFffffff))),
                      onPressed: () {
                        //TODO: register
                        registrationViewModel.validate(context, 7);
                      },),),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.arrow_circle_right_rounded, size: 28, color: ColorManager.white),
                      ),),),
                ],
              ),
            ],
          ),
        ),
        //----------------------------------------------------------------------
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
              color: const Color(0xE6ffffff),
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child: ProgressDots(pageNumber: pageNumber, pages: pages)),)
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
