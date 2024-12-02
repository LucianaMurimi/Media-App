import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/shared_components/progress_dots.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';


class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> with AutomaticKeepAliveClientMixin {
  int pageNumber = 5;
  int pages = 7;

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RegistrationViewModel registrationViewModel = Provider.of<RegistrationViewModel>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
          child: Column(
            children: [
              const SizedBox(height: 52,),
              // email
              TextFormField(
                controller: _emailController,
                onChanged: (val)=>registrationViewModel.email.value = val,
                validator: (_){return registrationViewModel.email.error;},
                autovalidateMode: AutovalidateMode.always,

                keyboardType: TextInputType.emailAddress,
                cursorColor: const Color(0x80323232),
                decoration: CustomizedInputDecoration.textFormFieldStyle(
                  labelText: AppLocalizations.of(context)!.email,
                  hintText: AppLocalizations.of(context)!.emailHintText,
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      registrationViewModel.validate(context, 6);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.next,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)), // Text for the button
                        const SizedBox(width: 12,),
                        const Icon(Icons.arrow_circle_right_rounded),
                      ],
                    ),
                  )
              )
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
