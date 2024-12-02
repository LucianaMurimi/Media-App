class Post{
  String uid;
  String timestamp;
  String username;
  List image; //list of image address
  List likes = []; //list of users who like the post
  List comments = [];  //list of maps [{'username1': 'comment1'}, {'username2':'comment2']
  String caption;

  Post({
    required this.uid,
    required this.timestamp,
    required this.username,
    required this.image,
    required this.likes,
    required this.comments,
    required this.caption,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'timestamp': timestamp,
      'username': username,
      'image': image,
      'likes': likes,
      'comments': comments,
      'caption': caption,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      uid: map['uid'],
      timestamp: map['timestamp'],
      username: map['username'],
      image: map['image'],
      likes: map['likes'],
      comments: map['comments'],
      caption: map['caption'],
    );
  }
}