class TUser{
  String name;
  String username;
  String role;
  String email;
  String profilePicture;
  String bio;
  String location;

  TUser({
    required this.name,
    required this.username,
    required this.role,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.location
  });

  Map<String, dynamic> toMap() {
    return {
    'name': name,
    'username': username,
    'role': role,
    'email': email,
    'profilePicture': profilePicture,
    'bio': bio,
    'location': location
    };
  }

  static TUser fromMap(Map<String, dynamic> map) {
    return TUser(
      name: map['name'],
      username: map['username'],
      role: map['role'],
      email: map['email'],
      profilePicture: map['profilePicture'],
      bio: map['bio'],
      location: map['location']
    );
  }
}