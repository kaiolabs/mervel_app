class Client {
  final int id;
  final String email;
  final String favoritos;

  Client({
    this.id = 0,
    this.email = '',
    this.favoritos = '',
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] ?? 0,
      email: map['email'] ?? '',
      favoritos: map['favoritos'] ?? '',
    );
  }

  factory Client.empty() {
    return Client(
      id: 0,
      email: '',
    );
  }
}
