// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_status_read_but_not_liked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStatusReadButNotLiked _$BookStatusReadButNotLikedFromJson(
        Map<String, dynamic> json) =>
    BookStatusReadButNotLiked(
      dateStart: json['dateStart'] == null
          ? null
          : DateTime.tryParse(json['dateStart'] as String),
      dateEnd: json['dateEnd'] == null
          ? null
          : DateTime.tryParse(json['dateEnd'] as String),
      reasons:
          (json['reasons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BookStatusReadButNotLikedToJson(
        BookStatusReadButNotLiked instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
      'dateEnd': instance.dateEnd?.toIso8601String(),
      'reasons': instance.reasons,
      'comments': instance.comments,
    };
