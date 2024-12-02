class SACCOS{
  String name;
  String logo;
  String type; // employee-based or community-based
  String description;
  String location;

  SACCOS({
    required this.name,
    required this.logo,
    required this.type,
    required this.description,
    required this.location
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logo,
      'type': type,
      'description': description,
      'location': location,
    };
  }

  static SACCOS fromMap(Map<String, dynamic> map) {
    return SACCOS(
      name: map['name'],
      logo: map['logo'],
      type: map['type'],
      description: map['description'],
      location: map['location'],
    );
  }
}