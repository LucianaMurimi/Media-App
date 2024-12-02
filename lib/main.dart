import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/application/locator.dart';
import 'package:sccult_media/domain/usecase/authentication_usecase.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/screens/menu/menu_vm.dart';
import 'package:sccult_media/provider/locale_provider.dart';
import 'package:sccult_media/application/app.dart';
import 'presentation/screens/authenticate/login/login_vm.dart';
import 'presentation/screens/authenticate/password_reset/password_reset_vm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setUpLocator(); //dependency injection

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(
      Phoenix(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>LocaleProvider(const Locale('sw', ''))),
            ChangeNotifierProvider(create: (_)=>LoginViewModel(locator<LoginUseCase>())),
            ChangeNotifierProvider(create: (_)=>PasswordResetViewModel()),
            ChangeNotifierProvider(create: (_)=>MenuViewModel(locator<LogoutUseCase>())),
            ChangeNotifierProvider(create: (_)=>ViewState()),
          ],
          child: const App(),
        )
      )
  ));
}


