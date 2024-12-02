import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_widgets/name.dart';
import 'package:sccult_media/presentation/shared_components/progress_dots.dart';

class Role extends StatefulWidget {
  const Role({Key? key, }) : super(key: key);

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> with AutomaticKeepAliveClientMixin {
  int pageNumber = 0;
  int pages = 7;

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    final RegistrationViewModel registrationViewModel = Provider.of<RegistrationViewModel>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              Text(AppLocalizations.of(context)!.registerAs,
                  style: const TextStyle(fontSize: 16,)),
              const SizedBox(height: 16,),
              Table(
                border: TableBorder.all(color: ColorManager.paleGray),
                children: [
                  TableRow(
                    children: [
                      RadioListTile<String>(
                        title: Text(AppLocalizations.of(context)!.anIndividual),
                        value: 'individual',
                        groupValue: selectedType,
                        onChanged: (String? value) {
                          setState(() {
                            selectedType = value;
                            registrationViewModel.role.value = 'level1';
                          });
                        },
                      ),
                    ]
                  ),
                  TableRow(
                      children: [
                        RadioListTile<String>(
                          title: Text(AppLocalizations.of(context)!.anInstitution),
                          value: 'institution',
                          groupValue: selectedType,
                          onChanged: (String? value) {
                            setState(() {
                              selectedType = value;
                              registrationViewModel.role.value = 'level2';
                            });
                          },
                        ),
                      ]
                  )
                ],
              ),
              Visibility(
                visible: registrationViewModel.role.error != null, // Make sure visibility is set correctly
                child: Column(
                  children: [
                    const SizedBox(height: 4,),
                    Text(registrationViewModel.role.error?.toString() ?? '',
                      style: TextStyle(color: ColorManager.red),),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    registrationViewModel.validate(context, 1);
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
