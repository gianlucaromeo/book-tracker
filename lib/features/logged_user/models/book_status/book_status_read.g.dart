part of 'book_status_read.dart';

BookStatusRead _$BookStatusReadFromJson(Map<String, dynamic> json) =>
    BookStatusRead(
      dateStart: json['dateStart'] == null
          ? null
          : DateTime.tryParse(json['dateStart'] as String),
      dateEnd: json['dateEnd'] == null
          ? null
          : DateTime.tryParse(json['dateEnd'] as String),
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      liked: json['liked'] as bool?,
    );

Map<String, dynamic> _$BookStatusReadToJson(BookStatusRead instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toString(),
      'dateEnd': instance.dateEnd?.toString(),
      'rating': instance.rating,
      'comment': instance.comment,
      'liked': instance.liked,
    };
