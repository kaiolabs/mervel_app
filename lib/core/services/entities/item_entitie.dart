class ItemEntitie {
  final String resourceURI;
  final String name;
  final String type;

  ItemEntitie({
    this.resourceURI = '',
    this.name = '',
    this.type = '',
  });

  factory ItemEntitie.fromJson(Map<String, dynamic> json) {
    return ItemEntitie(
      resourceURI: json['resourceURI'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
