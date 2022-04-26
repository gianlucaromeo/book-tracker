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
          : DateTime.tryParse(json['dateStart'] as String),
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      liked: json['liked'] as bool?,
    );

Map<String, dynamic> _$BookStatusCurrentlyReadingToJson(
        BookStatusCurrentlyReading instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
      'rating': instance.rating,
      'comment': instance.comment,
      'liked': instance.liked,
      'type': instance.type.name,
    };
