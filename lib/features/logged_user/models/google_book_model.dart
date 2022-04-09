import 'package:json_annotation/json_annotation.dart';

part 'google_book_model.g.dart';

@JsonSerializable()
class GoogleBookModel {
  /// Book id for Google Books API.
  /// Useful to fetch more information if required.
  String? id;

  // VOLUME INFO
  String? title;
  List<String>? authors;
  String? publisher;
  DateTime? publishedDate;
  int? pageCount;
  String? description;
  List<String>? categories;
  num? averageRating; // 1.0 to 5.0
  int? ratingsCount;
  String? imageUrl; // ~ 128px
  String? language; // ISO 639-1 'fr', 'en', ...
  String? mainCategory; // ! Always null (?)

  GoogleBookModel();

  factory GoogleBookModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBookModelToJson(this);
}
