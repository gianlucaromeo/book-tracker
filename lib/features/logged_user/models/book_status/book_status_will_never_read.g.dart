// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_status_will_never_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStatusWillNeverRead _$BookStatusWillNeverReadFromJson(
        Map<String, dynamic> json) =>
    BookStatusWillNeverRead(
      reasons:
          (json['reasons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BookStatusWillNeverReadToJson(
        BookStatusWillNeverRead instance) =>
    <String, dynamic>{
      'reasons': instance.reasons,
      'comments': instance.comments,
    };
