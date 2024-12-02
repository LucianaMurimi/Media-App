import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'package:sccult_media/presentation/resources/assets_manager.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/resources/styles_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/login/login_vm.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final viewState = Provider.of<ViewState>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/header.png'), // replace with your image path
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter
              ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1. logo
                  const SizedBox(height: 36.0),
                  Image.asset(ImageAssets.sccultLogo, width: 148),
                  const SizedBox(height: 32.0),
                  Text(AppLocalizations.of(context)!.loginMessage,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                  const SizedBox(height: 20,),
                  // 2. email input
                  TextFormField(
                    controller: loginViewModel.emailController,
                    onChanged: (_){loginViewModel.setEmail(loginViewModel.emailController.value.text);},
                    validator: (_){return loginViewModel.email.error;},
                    autovalidateMode: AutovalidateMode.always,

                    keyboardType: TextInputType.emailAddress,
                    cursorColor: const Color(0x80323232),
                    decoration: CustomInputDecoration.textFormFieldStyle(
                      prefixIcon: const Icon(Icons.email, color: Color(0xB3000000), size: 18,),
                      labelText: AppLocalizations.of(context)!.email,
                      hintText: AppLocalizations.of(context)!.emailHintText,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // 3. password input
                  TextFormField(
                      controller: loginViewModel.passwordController,
                      onChanged: (_){loginViewModel.setPassword(loginViewModel.passwordController.value.text);},
                      onTap: (){loginViewModel.validateEmail(this.context, loginViewModel.email.value);},
                      validator: (_){return loginViewModel.password.error;},
                      autovalidateMode: AutovalidateMode.always,

                      obscureText: obscurePassword ? true : false,
                      cursorColor: const Color(0x80323232),
                      decoration: CustomInputDecoration.textFormFieldStyle(
                        prefixIcon: IconButton(
                          onPressed: (){setState(() {obscurePassword = !obscurePassword;});},
                          icon: obscurePassword ? const Icon(Icons.visibility_off, color: Color(0xB3000000), size: 18,)
                              : const Icon(Icons.visibility, color: Color(0xB3000000), size: 18,),
                        ),
                        labelText: AppLocalizations.of(context)!.password,
                        hintText: AppLocalizations.of(context)!.passwordHintText,
                      )
                  ),
                  const SizedBox(height: 12,),
                  // 4. password reset
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(AppLocalizations.of(context)!.resetPassword,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                      onPressed: (){
                        loginViewModel.resetPassword(context);
                      },
                    )
                  ),
                  const SizedBox(height: 16.0),
                  // 5. login
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                        width: double.infinity,
                        decoration: CustomButtonDecoration.buttonDecorationStyle(true),

                        child: TextButton(
                          child: viewState.appViewState == AppViewState.loading ? CircularProgressIndicator(color: ColorManager.white,) :
                            Text(AppLocalizations.of(context)!.login, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, letterSpacing: 1.4, color: Color(0xFFffffff))),
                          onPressed: () {
                            //TODO: login
                            loginViewModel.login(
                                context,
                                viewState
                            );
                          },),),
                      Visibility(
                        visible: viewState.appViewState == AppViewState.content,
                        child: Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.arrow_circle_right_rounded, size: 28, color: ColorManager.white),
                            ),),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  // 6. register
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${AppLocalizations.of(context)!.register} ', style: const TextStyle(fontSize: 15.0) ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.registerLink,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                          onPressed: (){
                            loginViewModel.register(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
