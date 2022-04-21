// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_status_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStatusRead _$BookStatusReadFromJson(Map<String, dynamic> json) =>
    BookStatusRead(
      dateStart: json['dateStart'] == null
          ? null
          : DateTime.parse(json['dateStart'] as String),
      dateEnd: json['dateEnd'] == null
          ? null
          : DateTime.parse(json['dateEnd'] as String),
      rating: json['rating'] as int?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      savedPages:
          (json['savedPages'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$BookStatusReadToJson(BookStatusRead instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
      'dateEnd': instance.dateEnd?.toIso8601String(),
      'rating': instance.rating,
      'comments': instance.comments,
      'savedPages': instance.savedPages,
    };
