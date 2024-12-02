import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/application/locator.dart';
import 'package:sccult_media/domain/usecase/registration_usecase.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/email.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/location.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/name.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/password.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/profile_pic.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/role.dart';

import 'registration_widgets/bio.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final PageController pageController = PageController();

  void _handlePageChange(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationViewModel(onPageChange: _handlePageChange, registrationUseCase: locator<RegistrationUseCase>()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6750A4),
          iconTheme: const IconThemeData(color: Color(0xFFffffff)),
          elevation: 2.0,
      
          toolbarHeight: 96.0,
      
          titleSpacing: 0,
      
          automaticallyImplyLeading: true,
      
          title: Text(AppLocalizations.of(context)!.registration,
              style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.white, fontSize: 20.0)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(onPressed: (){setState(() {
                Navigator.of(context).pop();
              });}, icon: const Icon(Icons.clear, size: 28,),),
            )],
        ),
        body: PageView(
          controller: pageController,
          children: const [
            Role(),
            Name(),
            ProfilePic(),
            Bio(),
            Location(),
            Email(),
            Password(),
          ],
        ),
      ),
    );
  }
}
