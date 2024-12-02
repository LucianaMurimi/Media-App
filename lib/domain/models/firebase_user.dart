class FirebaseUser{
  FirebaseUser({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.disabled,
  });

  String uid;
  String email;
  bool emailVerified;
  bool disabled;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'emailVerified': emailVerified,
      'disabled': disabled,
    };
  }

  static FirebaseUser fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      uid: map['uid'],
      email : map['email'],
      emailVerified : map['emailVerified'],
      disabled : map['disabled'],
    );
  }
}