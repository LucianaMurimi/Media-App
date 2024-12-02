import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedPost extends StatefulWidget {

  final String username;
  final int likes;
  final String time;
  final String profilePicture;
  final String image;

  const FeedPost({Key? key,
    required this.username,
    required this.likes,
    required this.time,
    required this.profilePicture,
    required this.image
  }) : super(key: key);

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  bool isLiked = false;
  bool displayHeart = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(widget.profilePicture),
                  ),
                  const SizedBox(width: 10.0),
                  Text(widget.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                ],
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        ),

        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLiked = !isLiked;
              displayHeart = true;
            });
            Future.delayed(const Duration(milliseconds: 750), () {
              setState(() {
                displayHeart = false;
              });
            });
          },
          child: displayHeart == true ? Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(widget.image, fit: BoxFit.cover),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: const Center(child: Icon(FontAwesomeIcons.solidHeart, color: Colors.white, size: 80.0))
              ),
            ],
          ) : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Image.asset(widget.image, fit: BoxFit.cover),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLiked == true ? const Icon(FontAwesomeIcons.solidHeart, color: Colors.red, size: 25.0) : const Icon(FontAwesomeIcons.heart, size: 25.0),
                  const SizedBox(width: 15.0),
                  const Icon(FontAwesomeIcons.comment, size: 25.0),
                  const SizedBox(width: 15.0),
                ],
              ),

              const Icon(FontAwesomeIcons.bookmark, size: 25.0)
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('${widget.likes} likes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Text('${widget.time} ago', style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
        )
      ],
    );
  }
}