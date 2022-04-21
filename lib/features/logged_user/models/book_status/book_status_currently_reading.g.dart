// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_status_currently_reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStatusCurrentlyReading _$BookStatusCurrentlyReadingFromJson(
        Map<String, dynamic> json) =>
    BookStatusCurrentlyReading(
      dateStart: json['dateStart'] == null
          ? null
          : DateTime.parse(json['dateStart'] as String),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      savedPages:
          (json['savedPages'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$BookStatusCurrentlyReadingToJson(
        BookStatusCurrentlyReading instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
      'comments': instance.comments,
      'savedPages': instance.savedPages,
    };
