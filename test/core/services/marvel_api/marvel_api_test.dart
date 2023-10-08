import 'package:flutter_test/flutter_test.dart';
import 'package:mervel_app/core/services/entities/character_entitie.dart';
import 'package:mervel_app/core/services/entities/comic_entitie.dart';
import 'package:mervel_app/core/services/marvel_api/marvel_api.dart';

void main() {
  MarvelApi marvelApi;

  test('MarvelApi.getCharacters() should return a list of CharacterEntitie', () async {
    marvelApi = MarvelApi();
    final res = await marvelApi.getCharacters();
    expect(res, isA<List<CharacterEntitie>>());
  });

  test('MarvelApi.getComic() should return a ComicEntitie', () async {
    marvelApi = MarvelApi();
    final res = await marvelApi.getComic('https://gateway.marvel.com/v1/public/comics/82967');
    expect(res, isA<ComicEntitie>());
  });

  test('MarvelApi.getComic() should return a ComicEntitie with empty values', () async {
    marvelApi = MarvelApi();
    final res = await marvelApi.getComic('https://gateway.marvel.com/v1/public/comics/0');
    expect(res, isA<ComicEntitie>());
    expect(res.title, '');
  });

  test('MarvelApi.getCharacters() verify if offset is being incremented correctly', () async {
    marvelApi = MarvelApi();
    final res = await marvelApi.getCharacters();
    expect(res, isA<List<CharacterEntitie>>());
    expect(res.length, marvelApi.limit);
    expect(marvelApi.offset, marvelApi.limit);

    final res2 = await marvelApi.getCharacters();
    expect(res2, isA<List<CharacterEntitie>>());
    expect(res2.length, marvelApi.limit);
    expect(marvelApi.offset, marvelApi.limit * 2);
  });
}
