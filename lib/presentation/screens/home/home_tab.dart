import 'package:flutter/material.dart';
import 'package:sccult_media/presentation/screens/home/feed_post.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // StoriesWidget(),
        FeedPost(username: 'samwilson', likes: 102, time: '2 hours', profilePicture: 'assets/images/Sam Wilson.jpg', image: 'assets/images/story1.jpg'),
        FeedPost(username: 'eddisonalfred', likes: 156, time: '6 hours', profilePicture: 'assets/images/eddison.jpg', image: 'assets/images/story2.jpg'),
        FeedPost(username: 'adelle_klarke', likes: 56, time: '2 days', profilePicture: 'assets/images/adelle.jpg', image: 'assets/images/story3.jpg'),
        FeedPost(username: 'matthewsimpson', likes: 224, time: '1 week', profilePicture: 'assets/images/mathew.jpg', image: 'assets/images/story4.jpg'),
        FeedPost(username: 'ryanconnor', likes: 112, time: '2 weeks', profilePicture: 'assets/images/ryan.jpg', image: 'assets/images/story8.jpg'),
      ],
    );
  }
}


