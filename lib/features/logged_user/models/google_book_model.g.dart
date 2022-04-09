// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBookModel _$GoogleBookModelFromJson(Map<String, dynamic> json) =>
    GoogleBookModel()
      ..id = json['id'] as String?
      ..title = json["volumeInfo"]['title'] as String?
      ..authors = (json["volumeInfo"]['authors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..publisher = json["volumeInfo"]['publisher'] as String?
      ..publishedDate = json["volumeInfo"]['publishedDate'] == null
          ? null
          : DateTime.tryParse(json["volumeInfo"]['publishedDate'])
      ..pageCount = json["volumeInfo"]['pageCount'] as int?
      ..description = json["volumeInfo"]['description'] as String?
      ..categories = (json["volumeInfo"]['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..averageRating = json["volumeInfo"]['averageRating'] as num?
      ..ratingsCount = json["volumeInfo"]['ratingsCount'] as int?
      ..imageUrl = json["volumeInfo"]['imageLinks']?['thumbnail'] as String?
      ..language = json["volumeInfo"]['language'] as String?
      ..mainCategory = json["volumeInfo"]['mainCategory'] as String?;

Map<String, dynamic> _$GoogleBookModelToJson(GoogleBookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate?.toString(),
      'pageCount': instance.pageCount,
      'description': instance.description,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'ratingsCount': instance.ratingsCount,
      'imageUrl': instance.imageUrl,
      'language': instance.language,
      'mainCategory': instance.mainCategory,
    };
