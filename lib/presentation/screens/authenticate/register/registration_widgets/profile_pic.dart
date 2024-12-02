import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/register/registration_vm.dart';
import 'package:sccult_media/presentation/shared_components/progress_dots.dart';
import 'package:sccult_media/presentation/shared_components/shared_components_styles.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> with AutomaticKeepAliveClientMixin {
  int pageNumber = 2;
  int pages = 7;

  File? _image;
  final picker = ImagePicker();

  // Image Picker function to get image from gallery
  Future<File?> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> showOptions(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF666666)),
              title: Text(
                AppLocalizations.of(context)!.photoGallery,
                style: const TextStyle(fontSize: 15.0),
              ),
              onTap: () async {
                Navigator.pop(context, await getImageFromGallery());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Add this line to ensure AutomaticKeepAliveClientMixin works

    final RegistrationViewModel registrationViewModel = Provider.of<RegistrationViewModel>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
          child: Column(
            children: [
              const SizedBox(height: 52),
              // Profile pic
              OutlinedButton(
                onPressed: () async {
                  File? image = await showOptions(context);
                  if (image != null) {
                    setState(() {
                      _image = image;
                    });
                    registrationViewModel.profilePictureImage = image;
                    registrationViewModel.validate(context, 3);
                  }
                },
                child: Text(AppLocalizations.of(context)!.uploadProfilePicture),
              ),
              const SizedBox(height: 16),
              Center(
                child: _image == null
                    ? Text(
                  AppLocalizations.of(context)!.noImage,
                  style: const TextStyle(color: Color(0xFF666666)),
                )
                    : CircleAvatar(
                  radius: 60, // Adjust the radius as needed
                  child: ClipOval(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    registrationViewModel.validate(context, 3);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.next,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                      ), // Text for the button
                      const SizedBox(width: 12),
                      const Icon(Icons.arrow_circle_right_rounded),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // ----------------------------------------------------------------------
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: const Color(0xE6ffffff),
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            child: ProgressDots(pageNumber: pageNumber, pages: pages),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
