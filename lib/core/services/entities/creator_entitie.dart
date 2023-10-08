class CreatorEntitie {
  String resourceURI;
  String name;
  String role;

  CreatorEntitie({
    this.resourceURI = '',
    this.name = '',
    this.role = '',
  });

  factory CreatorEntitie.fromJson(Map<String, dynamic> json) {
    return CreatorEntitie(
      resourceURI: json['resourceURI'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
