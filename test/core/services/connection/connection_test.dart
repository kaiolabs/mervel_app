import 'package:flutter_test/flutter_test.dart';
import 'package:mervel_app/core/services/connection/Implementation/connection.dart';

void main() {
  Connection connection = Connection();

  test('Test method get', () async {
    const String url = 'https://jsonplaceholder.typicode.com/todos/1';
    final res = await connection.get(url);

    expect(res.$1, true);
    expect(res.$2.isNotEmpty, true);
    expect(res.$2['userId'], 1);
    expect(res.$2['id'], 1);
    expect(res.$2['title'], 'delectus aut autem');
    expect(res.$2['completed'], false);
  });

  test('Test method post', () async {
    const String url = 'https://jsonplaceholder.typicode.com/posts';
    final res = await connection.post(url, body: {
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    });

    expect(res['title'], 'foo');
    expect(res['body'], 'bar');
    expect(res['userId'], 1);
    expect(res['id'], 101);
  });
}
