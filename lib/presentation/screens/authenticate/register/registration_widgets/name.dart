import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/shared_components/progress_dots.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> with AutomaticKeepAliveClientMixin{
  int pageNumber = 1;
  int pages = 7;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
              //1. Name
              TextFormField(
                controller: _nameController,
                onChanged: (val)=>registrationViewModel.name.value = val,
                validator: (_){return registrationViewModel.name.error;},
                autovalidateMode: AutovalidateMode.always,

                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                  FilteringTextInputFormatter.deny(RegExp(r"\s\s")),
                ],
                cursorColor: const Color(0x80323232),
                decoration: CustomizedInputDecoration.textFormFieldStyle(
                  labelText: AppLocalizations.of(context)!.name,
                  hintText: AppLocalizations.of(context)!.nameHintText,
                ),
              ),
              const SizedBox(height: 16,),
              //2. Username
              TextFormField(
                controller: _usernameController,
                onChanged: (val)=>registrationViewModel.username.value = val,
                validator: (_){return registrationViewModel.username.error;},
                autovalidateMode: AutovalidateMode.always,

                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                  FilteringTextInputFormatter.deny(RegExp(r"\s\s")),
                ],
                cursorColor: const Color(0x80323232),
                decoration: CustomizedInputDecoration.textFormFieldStyle(
                  labelText: AppLocalizations.of(context)!.username,
                  hintText: AppLocalizations.of(context)!.username,
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      registrationViewModel.validate(context, 2);
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
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: ProgressDots(pageNumber: pageNumber, pages: pages)),)
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
