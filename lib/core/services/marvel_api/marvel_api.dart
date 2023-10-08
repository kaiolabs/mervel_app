import 'package:mervel_app/core/services/connection/Implementation/connection.dart';
import 'package:mervel_app/core/services/entities/comic_entitie.dart';

import '../entities/character_entitie.dart';

class MarvelApi {
  final String baseUrl = 'https://gateway.marvel.com/';
  final String apiKey = 'b0757130211b52be07b670bb9fc8b734';
  final String hash = 'c56f924aef2a5dfc5287cff81135e62b';
  final String ts = '1';
  int limit = 10;
  int offset = 0;
  int max = 0;

  Connection connection = Connection();

  Future<List<CharacterEntitie>> getCharacters() async {
    List<CharacterEntitie> characters = [];

    final String url = '$baseUrl/v1/public/characters?apikey=$apiKey&hash=$hash&ts=$ts&limit=$limit&offset=$offset';
    final res = await connection.get(url);

    if (res.$1) {
      if (res.$2.isNotEmpty && res.$2['data'].isNotEmpty) {
        max = res.$2['data']['total'];

        if (res.$2['data']['results'].isNotEmpty) {
          for (var item in res.$2['data']['results']) {
            characters.add(CharacterEntitie.fromJson(item));
          }
        }
      }
    }

    offset += limit;
    return characters;
  }

  Future<ComicEntitie> getComic(String link) async {
    final String url = '$link?apikey=$apiKey&hash=$hash&ts=$ts';
    final res = await connection.get(url);

    if (res.$1) {
      if (res.$2.isNotEmpty && res.$2['data'].isNotEmpty) {
        if (res.$2['data']['results'].isNotEmpty) {
          return ComicEntitie.fromJson(res.$2['data']['results'][0]);
        }
      }
    }
    return ComicEntitie();
  }
}
