import 'package:flutter/cupertino.dart';
import 'package:sccult_media/domain/usecase/authentication_usecase.dart';

class MenuViewModel extends ChangeNotifier{
  //dependencies
  MenuViewModel(this._logoutUseCase);
  LogoutUseCase _logoutUseCase;

  logout(BuildContext context){
    _logoutUseCase.execute(LogoutUseCaseInput(context: context));
  }
}