import 'package:book_tracker/features/logged_user/models/google_book_model_volume_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_book_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleBookModel {
  String? id;
  GoogleBookModelVolumeInfo? volumeInfo;

  GoogleBookModel();
  factory GoogleBookModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBookModelToJson(this);
}
