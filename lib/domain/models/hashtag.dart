class Hashtag{
  String uid;
  String hashtag;
  String postUid;

  Hashtag({
    required this.uid,
    required this.hashtag,
    required this.postUid,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'hashtag': hashtag,
      'postUid': postUid,
    };
  }

  static Hashtag fromMap(Map<String, dynamic> map) {
    return Hashtag(
      uid: map['uid'],
      hashtag: map['hashtag'],
      postUid: map['postUid'],
    );
  }

}