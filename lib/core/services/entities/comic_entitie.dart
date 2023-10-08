import 'creator_entitie.dart';

class ComicEntitie {
  int id;
  int digitalId;
  String title;
  double issueNumber;
  String variantDescription;
  String description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  String format;
  int pageCount = 0;
  List<Map> textObjects;
  String resourceURI;
  List<Map> urls;
  Map series;
  List<CreatorEntitie> creators;

  String thumbnail;

  ComicEntitie({
    this.id = 0,
    this.digitalId = 0,
    this.title = '',
    this.issueNumber = 0,
    this.variantDescription = '',
    this.description = '',
    this.modified = '',
    this.isbn = '',
    this.upc = '',
    this.diamondCode = '',
    this.ean = '',
    this.issn = '',
    this.format = '',
    this.pageCount = 0,
    this.textObjects = const [],
    this.resourceURI = '',
    this.urls = const [],
    this.series = const {},
    this.creators = const [],
    this.thumbnail = '',
  });

  factory ComicEntitie.fromJson(Map<String, dynamic> json) {
    return ComicEntitie(
      id: json['id'] ?? '',
      digitalId: json['digitalId'] ?? '',
      title: json['title'] ?? '',
      issueNumber: double.tryParse(json['issueNumber'].toString()) ?? 0,
      variantDescription: json['variantDescription'] ?? '',
      description: json['description'] ?? '',
      modified: json['modified'] ?? '',
      isbn: json['isbn'] ?? '',
      upc: json['upc'] ?? '',
      diamondCode: json['diamondCode'] ?? '',
      ean: json['ean'] ?? '',
      issn: json['issn'] ?? '',
      format: json['format'] ?? '',
      pageCount: json['pageCount'] ?? '',
      textObjects: json['textObjects'].map<Map>((item) => Map.from(item)).toList(),
      resourceURI: json['resourceURI'] ?? '',
      urls: json['urls'].map<Map>((item) => Map.from(item)).toList(),
      series: Map.from(json['series']),
      creators: json['creators']['items'].map<CreatorEntitie>((item) => CreatorEntitie.fromJson(item)).toList(),
      thumbnail: json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
    );
  }
}
