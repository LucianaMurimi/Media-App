import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._locale);

  static Future<String> _getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String locale = prefs.getString('locale') ?? 'sw';
    return locale;
  }

  Locale _locale = const Locale('sw', '');

  Locale get locale => _locale;

  Future setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode);

    _locale = locale;
    notifyListeners();
  }
}