// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_model_volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBookModelVolumeInfo _$GoogleBookModelVolumeInfoFromJson(
        Map<String, dynamic> json) =>
    GoogleBookModelVolumeInfo()
      ..title = json['title'] as String?
      ..authors =
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..publisher = json['publisher'] as String?
      ..publishedDate = json['publishedDate'] == null
          ? null
          : DateTime.tryParse(json['publishedDate'] as String)
      ..pageCount = json['pageCount'] as int?
      ..description = json['description'] as String?
      ..categories = (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..averageRating = json['averageRating'] as num?
      ..ratingsCount = json['ratingsCount'] as int?
      ..imageLinks = json['imageLinks'] == null
          ? null
          : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>)
      ..language = json['language'] as String?
      ..mainCategory = json['mainCategory'] as String?;

Map<String, dynamic> _$GoogleBookModelVolumeInfoToJson(
        GoogleBookModelVolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate?.toIso8601String(),
      'pageCount': instance.pageCount,
      'description': instance.description,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'ratingsCount': instance.ratingsCount,
      'imageLinks': instance.imageLinks?.toJson(),
      'language': instance.language,
      'mainCategory': instance.mainCategory,
    };
