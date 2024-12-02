import 'package:flutter/material.dart';
import 'package:sccult_media/presentation/screens/authenticate/login/login.dart';
import 'package:sccult_media/presentation/screens/authenticate/password_reset/password_reset.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/register.dart';
import 'package:sccult_media/presentation/screens/home/home_page.dart';

class Routes{
  static const String onBoardingRoute = "/onBoarding";
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String adminLoginRoute = "/adminLogin";
  static const String registerRoute = "/register";
  static const String resetPasswordRoute = "/forgotPassword";
  static const String adminHomeRoute = "/adminHome";
  static const String homeRoute = "/home";
}

class RoutesGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=> const Login());
      // case Routes.adminLoginRoute:
      //   return MaterialPageRoute(builder: (_)=> const AdminLogin());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_)=> const Register());
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_)=> const PasswordReset());
      case Routes.adminHomeRoute:
      //   return MaterialPageRoute(builder: (_)=> const AdminHome());
      default:
        return MaterialPageRoute(builder: (_)=> const Home());
    }
  }
}