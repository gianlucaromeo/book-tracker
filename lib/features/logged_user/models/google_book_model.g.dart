// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBookModel _$GoogleBookModelFromJson(Map<String, dynamic> json) =>
    GoogleBookModel()
      ..id = json['id'] as String?
      ..volumeInfo = json['volumeInfo'] == null
          ? null
          : GoogleBookModelVolumeInfo.fromJson(
              json['volumeInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$GoogleBookModelToJson(GoogleBookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'volumeInfo': instance.volumeInfo?.toJson(),
    };
