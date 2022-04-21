import 'package:json_annotation/json_annotation.dart';

part 'google_book_model_volume_info.g.dart';

@JsonSerializable()
class GoogleBookModelVolumeInfo {
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

  GoogleBookModelVolumeInfo();

  factory GoogleBookModelVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookModelVolumeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBookModelVolumeInfoToJson(this);
}