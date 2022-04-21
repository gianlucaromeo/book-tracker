// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_status_to_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStatusToRead _$BookStatusToReadFromJson(Map<String, dynamic> json) =>
    BookStatusToRead(
      dateStart: json['dateStart'] == null
          ? null
          : DateTime.parse(json['dateStart'] as String),
    );

Map<String, dynamic> _$BookStatusToReadToJson(BookStatusToRead instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
    };
