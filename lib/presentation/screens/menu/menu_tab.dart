import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/resources/assets_manager.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/menu/menu_vm.dart';
import 'package:sccult_media/provider/locale_provider.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({Key? key}) : super(key: key);

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final menuViewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 256,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 180,
                      // child: Image.asset('assets/images/menu_tab_cover.jpg', fit: BoxFit.cover)
                      child: Image.asset('assets/images/header.png', fit: BoxFit.cover)

            )),
                Positioned(
                  top: 36,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 36,
                  right: 14,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      child: IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/images/sccult.png'),
                        ),
                      ),
                    ),
                ),
                Positioned(
                  top: 192,
                  right: 14,
                  child: OutlinedButton(
                      onPressed: (){},
                      child: Text(AppLocalizations.of(context)!.editProfile)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Luciana Murimi", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                const SizedBox(height: 6,),
                Text("@LuciAna"),
                const SizedBox(height: 4,),
                Text("lucianamurimi@gmail.com"),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    Text("34 ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text('Channel Members',),
                  ],
                ),
                const SizedBox(height: 6,),
                // Row(
                //   children: [
                //     Icon(Icons.link, size: 18, color: const Color(0xFF666666),),
                //     // SizedBox(width: 4,),
                //     // Text('https://lucianamurimi.hashnode.dev/', style: TextStyle(color: ColorManager.blue),),
                //   ],
                // ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 18, color: const Color(0xFF666666),),
                    SizedBox(width: 4,),
                    Text('Nairobi, ', style: const TextStyle(color: const Color(0xFF666666))),
                    Text('Joined October 2018',style: const TextStyle(color: const Color(0xFF666666))),
                  ],
                ),
                const SizedBox(height: 16,),
                Text("About", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                const SizedBox(height: 4,),
                Text("The Savings and Credit Cooperative Union League of Tanzania (SCCULT) is the Umbrella Organization for SACCOS in Tanzania mainland. SCCULT (1992) LTD are advocators, lobbyists, representatives of the interests of SACCOS inside and outside the Country.",
                    ),
                SizedBox(height: 12,),
                Row(
                  children: [
                    Icon(Icons.link, size: 18, color: const Color(0xFF666666),),
                    SizedBox(width: 4,),
                    Text('https://lucianamurimi.hashnode.dev/', style: TextStyle(color: ColorManager.blue),),
                  ],
                ),
                SizedBox(height: 16,),
                Text(AppLocalizations.of(context)!.language, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                const SizedBox(height: 4,),
                Text(AppLocalizations.of(context)!.preferredLanguage),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: (){
                        localeProvider.setLocale(const Locale('en', ''));
                        Phoenix.rebirth(context);
                      },
                      icon: Row(
                        children: [
                          Icon(Icons.check_box_rounded,
                              color: localeProvider.locale == const Locale('en', '') ? ColorManager.green : const Color(0xFFc0c0c0)),
                          const SizedBox(width: 8,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image.asset(ImageAssets.enFlag),
                          ),
                        ],
                      ),
                      label: Text(AppLocalizations.of(context)!.english, style: const TextStyle(color: Color(0xFF020202)),),
                    ),
                    TextButton.icon(
                      onPressed: (){
                        localeProvider.setLocale(const Locale('sw', ''));
                        Phoenix.rebirth(context);
                      },
                      icon: Row(
                        children: [
                          Icon(Icons.check_box_rounded,
                              color: localeProvider.locale == const Locale('sw', '') ? ColorManager.green : const Color(0xFFc0c0c0)),
                          const SizedBox(width: 8,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image.asset(ImageAssets.swFlag),
                          ),
                        ],
                      ),
                      label: Text(AppLocalizations.of(context)!.kiswahili, style: const TextStyle(color: Color(0xFF020202)),),
                    )
                  ],
                ),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){
                            //TODO: Logout
                            menuViewModel.logout(context);
                          },
                          child: Text(AppLocalizations.of(context)!.logout, style: TextStyle(color: ColorManager.red, fontWeight: FontWeight.bold, fontSize: 15.0))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
