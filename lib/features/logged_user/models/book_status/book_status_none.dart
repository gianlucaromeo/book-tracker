import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_status_none.g.dart';

@JsonSerializable()
class BookStatusNone extends BookStatus {
  final String status = "none";
  BookStatusNone() : super();
  factory BookStatusNone.fromJson(Map<String, dynamic> json) =>
      _$BookStatusNoneFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusNoneToJson(this);
}
