import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/assets_manager.dart';
import 'package:sccult_media/presentation/screens/home/home_page.dart';
import 'package:sccult_media/provider/locale_provider.dart';
import 'package:sccult_media/presentation/resources/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class App extends StatefulWidget {
  const App({Key? key, }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late Future<FirebaseApp> _initialization;

  late AnimationController animationController;
  late Animation<double> fadeInAnimation;

  _getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _locale = prefs.getString('locale') ?? 'sw';
    return _locale;
  }
  late LocaleProvider localeProvider;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();

    animationController = AnimationController(
        duration: const Duration(seconds: 5), vsync: this,);

    final CurvedAnimation fadeInCurvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn);

    fadeInAnimation = Tween<double>(
        begin: 0,
        end: 1
    ).animate(fadeInCurvedAnimation);

    animationController.forward();
  }

  @override
  void didChangeDependencies() {
    localeProvider = Provider.of<LocaleProvider>(context);
    _getLocale().then((locale) => localeProvider.setLocale(Locale(locale, '')));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){

          //--------------------------------------------------------------------
          if(snapshot.hasError){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(body: Center(child: Text('${snapshot.error}'))),
            );
          }

          //--------------------------------------------------------------------
          if(snapshot.connectionState == ConnectionState.done){
            return MaterialApp(
              title: 'SCCULT Media App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),

              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('sw', ''),
                Locale('en'), // English
              ],
              locale: localeProvider.locale,

              debugShowCheckedModeBanner: false,
              onGenerateRoute: RoutesGenerator.getRoute,
              home: const Home(),
            );
          }
          //--------------------------------------------------------------------
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: AnimatedBuilder(
                    animation: fadeInAnimation,
                    child: Image.asset(ImageAssets.logo, height: 96 * fadeInAnimation.value),
                    builder: (context, child){
                      return Center(child: child);
                    })),
          );

        });
  }
}