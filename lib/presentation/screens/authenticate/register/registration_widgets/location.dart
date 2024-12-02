import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/locations_tz.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/shared_components/progress_dots.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';


class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> with AutomaticKeepAliveClientMixin{
  int pageNumber = 4;
  int pages = 7;

  final TextEditingController _locationController = TextEditingController();

  final suggestionKey = GlobalKey();
  ScrollController scrollController = ScrollController();

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
              // location
              TypeAheadField(
                controller: _locationController,
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    cursorColor: const Color(0x80323232),
                    decoration: CustomizedInputDecoration.textFormFieldStyle(
                        labelText: AppLocalizations.of(context)!.location,
                    )
                  );
                },
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                suggestionsCallback: (String query) =>
                    List.of(locationsTz).where((location) {
                      final locationLower = location.toLowerCase();
                      final queryLower = query.toLowerCase();
                      return locationLower.contains(queryLower);
                    }).toList(),
                onSelected: (String? suggestion) => {
                  setState((){}),
                  _locationController.text = suggestion!,
                  registrationViewModel.location.value = suggestion,
                },
              ),
              const SizedBox(height: 20,),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      registrationViewModel.validate(context, 5);
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
