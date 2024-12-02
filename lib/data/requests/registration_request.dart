class RegistrationRequest{
  RegistrationRequest({
    required this.name,
    required this.username,
    required this.role,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.location,
  });

  String? name;
  String? username;
  String? role;
  String? email;
  String? profilePicture;
  String? bio;
  String? location;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'role': role,
      'email': email,
      'profilePicture': profilePicture,
      'bio': bio,
      'location': location,
    };
  }
}