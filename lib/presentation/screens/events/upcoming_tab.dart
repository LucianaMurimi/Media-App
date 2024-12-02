import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sccult_media/presentation/resources/assets_manager.dart';
import 'package:sccult_media/presentation/resources/color_manager.dart';
import 'package:sccult_media/presentation/resources/routes_manager.dart';
import 'package:sccult_media/presentation/screens/events/events_widgets/events_card.dart';

class UpcomingTab extends StatefulWidget {
  const UpcomingTab({Key? key}) : super(key: key);

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

class _UpcomingTabState extends State<UpcomingTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper.jpg'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Transform.rotate(
                      angle: 45 * math.pi / 180, // Convert 45 degrees to radians
                      child: Icon(Icons.push_pin, color: ColorManager.red,),
                    ),
                    title: Text('The Enchanted Nightingale',),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // TextButton(
                      //   child: const Text('CONTACT'),
                      //   onPressed: () {/* ... */},
                      // ),TextButton(
                      //   child: const Text('CONTACT'),
                      //   onPressed: () {/* ... */},
                      // ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('MORE DETAILS'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),
            CustomHomePageCard(
                cardImage: "assets/images/wallpaper.jpg",
                cardTitle: "Cybersecurity Awareness Workshop",
                cardContent: 'In 2021, we invited you to join us for #30DaysOfFlutter to kickstart your learning journey and meet Flutter experts in the community.',
                actionBtnMsg: "Register",
                onPressed: (){

                }
            ),
            SizedBox(height: 20,),
            CustomHomePageCard(
                cardImage: "assets/images/wallpaper.jpg",
                cardTitle: "Cybersecurity Awareness Workshop",
                cardContent: 'Music by Julie Gable. Lyrics by Sidney Stein.',
                actionBtnMsg: "Register",
                onPressed: (){

                }
            ),
            SizedBox(height: 20,),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Transform.rotate(
                      angle: 45 * math.pi / 180, // Convert 45 degrees to radians
                      child: Icon(Icons.push_pin, color: ColorManager.red,),
                    ),
                    title: Text('The Enchanted Nightingale',),
                    subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // TextButton(
                      //   child: const Text('CONTACT'),
                      //   onPressed: () {/* ... */},
                      // ),TextButton(
                      //   child: const Text('CONTACT'),
                      //   onPressed: () {/* ... */},
                      // ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('MORE DETAILS'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
