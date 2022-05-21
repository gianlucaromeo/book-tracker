import 'package:book_tracker/features/logged_user/models/google_book_model_volume_info_image_links.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_book_model_volume_info.g.dart';

@JsonSerializable(explicitToJson: true)
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
  ImageLinks? imageLinks;
  String? language; // ISO 639-1 'fr', 'en', ...
  String? mainCategory; // ! Always null (?)

  GoogleBookModelVolumeInfo();

  factory GoogleBookModelVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookModelVolumeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBookModelVolumeInfoToJson(this);

  /* UTIL */
  String get authorsAsString {
    String authorsToString = '';
    if (authors != null) {
      for (int i = 0; i < authors!.length; i++) {
        final currentAuthor = authors![i];
        if (i != authors!.length - 2 && i != 0) {
          authorsToString += ', ';
        }
        authorsToString += currentAuthor;
      }
    }
    return authorsToString;
  }

  String get categoriessAsString {
    String categoriesToString = '';
    if (categories != null) {
      for (int i = 0; i < categories!.length; i++) {
        final currentCategory = categories![i];
        if (i != categories!.length - 2 && i != 0) {
          categoriesToString += ', ';
        }
        categoriesToString += currentCategory;
      }
    }
    return categoriesToString;
  }
}
