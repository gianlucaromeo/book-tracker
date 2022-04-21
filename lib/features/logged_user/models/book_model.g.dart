// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      bookData:
          GoogleBookModel.fromJson(json['bookData'] as Map<String, dynamic>),
      bookStatus:
          BookStatus.fromJson(json['bookStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'bookData': instance.bookData.toJson(),
      'bookStatus': instance.bookStatus.toJson(),
    };
