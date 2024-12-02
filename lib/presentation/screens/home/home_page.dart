import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sccult_media/presentation/helpers/view_state.dart';
import 'dart:math' as math;
import 'package:sccult_media/presentation/resources/assets_manager.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/screens/authenticate/login/login.dart';
import 'package:sccult_media/presentation/screens/channels/my_channels_tab.dart';
import 'package:sccult_media/presentation/screens/events/upcoming_tab.dart';
import 'package:sccult_media/presentation/screens/menu/menu_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_tab.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _search = false;
  final searchItemController = TextEditingController();

  String? email;
  bool _isUserLoggedIn = false;

  Future getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    return email;
  }

  @override
  void initState() {
    getPrefs().then((value){
      if(value == null){
        _isUserLoggedIn = false;
        setState(() { });
      }else{
        _isUserLoggedIn = true;
        setState(() { });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color(0xFF000000)),
          elevation: 2.0,

          toolbarHeight: 96.0,

          titleSpacing: 0,

          automaticallyImplyLeading: false,

          title: Container(
            padding: const EdgeInsets.only(right: 0.0, ),

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: _search ? [
                  // Search
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(8.0),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: IconButton(
                                    icon: const Icon(Icons.search_rounded, size: 24),
                                    onPressed: (){
                                      var searchItem = searchItemController.text;

                                      setState(() {
                                        _search = !_search;

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => SearchResults(searchItem)),
                                        // );
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.675,

                                  child: TextField(
                                    controller: searchItemController,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!.saccosName,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 24),
                              onPressed: (){
                                setState(() {
                                  _search = !_search;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
                //----------------------------------------------------------------
                    :
                [
                  Row(
                    children: [
                      const SizedBox(width: 16,),
                      Image.asset(ImageAssets.logo, width: 95,),
                      const SizedBox(width: 12,),
                      const Text('SCCULT Media App', style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20.0),),
                    ],
                  ),
                  Visibility(
                    visible: !_isUserLoggedIn,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Login(
                                    // profilePicture: ImageAssets.logo, savedPosts: 2, posts: 3, members: 3,
                                  )),
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.login),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor, // Text color
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isUserLoggedIn,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: 90 * math.pi / 180,
                        child: IconButton(
                          icon: const Icon(Icons.search_rounded, size: 24),
                          onPressed: (){
                            setState(() {
                              _search = !_search;
                            });
                          },
                        ),
                      ),

                      IconButton(onPressed: (){
                        // On pressing the menu button => the menu screen is served
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MenuTab(
                                // profilePicture: ImageAssets.logo, savedPosts: 2, posts: 3, members: 3,
                              )),
                        );
                      }, icon: const Icon(Icons.menu_rounded, color: Color(0xFF000000), size: 28)),
                      SizedBox(width: 4.0,)
                    ],
                  ),),


                ]
              //----------------------------------------------------------------
            ),
          ),

          bottom: TabBar(
            indicatorWeight: 2,
            // indicatorColor: const Color(0xFF379bf4),

            tabs: [
              Tab(child: Text(AppLocalizations.of(context)!.home,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 14.0),
              ),),
              Tab(child: Text(AppLocalizations.of(context)!.myChannels,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 14.0),
              ),),
              Tab(child: Text(AppLocalizations.of(context)!.upcoming,
                style: const TextStyle(color: Color(0xFF000000), fontSize: 14.0),
              ),),
            ],
          ),

        ),
        body: const TabBarView(
          children: [
            //------------------------------------------------------------------
            //1. Home
            SingleChildScrollView(
                child: HomeTab()
            ),
            //------------------------------------------------------------------
            //2. My Channels
            SingleChildScrollView(
                child: MyChannelsTab()
            ),
            //------------------------------------------------------------------
            //3. Upcoming
            SingleChildScrollView(
                child: UpcomingTab()
            ),
          ],
        ),
      ),
    );
  }
}
