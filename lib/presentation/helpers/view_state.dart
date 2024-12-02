import 'package:flutter/material.dart';

enum AppViewState {
  content,
  loading,
  error
}

class ViewState extends ChangeNotifier{
  AppViewState _appViewState = AppViewState.content;

  AppViewState get appViewState => _appViewState;

  void setViewState(AppViewState appViewState){
    _appViewState = appViewState;
    notifyListeners();
  }
}