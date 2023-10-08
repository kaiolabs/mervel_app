import 'comic_entitie.dart';
import 'item_entitie.dart';

class CharacterEntitie {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final String resourceURI;
  final List<ItemEntitie> comics;
  final List<ItemEntitie> series;
  final List<ItemEntitie> stories;
  final List<ItemEntitie> events;
  final List urls;

  List<ComicEntitie> comicsEntities = [];

  CharacterEntitie({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.thumbnail = '',
    this.resourceURI = '',
    this.comics = const [],
    this.series = const [],
    this.stories = const [],
    this.events = const [],
    this.urls = const [],
  });

  factory CharacterEntitie.fromJson(Map<String, dynamic> json) {
    return CharacterEntitie(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      description: json['description'],
      thumbnail: json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
      resourceURI: json['resourceURI'],
      series: json['series']['items'].map<ItemEntitie>((item) => ItemEntitie.fromJson(item)).toList(),
      stories: json['stories']['items'].map<ItemEntitie>((item) => ItemEntitie.fromJson(item)).toList(),
      events: json['events']['items'].map<ItemEntitie>((item) => ItemEntitie.fromJson(item)).toList(),
      comics: json['comics']['items'].map<ItemEntitie>((item) => ItemEntitie.fromJson(item)).toList(),
      urls: json['urls'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'resourceURI': resourceURI,
      'series': series,
      'stories': stories,
      'events': events,
      'comics': comics,
      'urls': urls,
    };
  }
}
