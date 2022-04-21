import 'package:json_annotation/json_annotation.dart';

part 'book_status.g.dart';

@JsonSerializable()
class BookStatus {
  BookStatus();
  factory BookStatus.fromJson(Map<String, dynamic> json) =>
      _$BookStatusFromJson(json);

  Map<String, dynamic> toJson() => _$BookStatusToJson(this);
}
