import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_status_to_read.g.dart';

@JsonSerializable()
class BookStatusToRead extends BookStatus {
  final BookStatusType type = BookStatusType.toRead;
  DateTime? dateStart;
  bool? sendNotification;

  BookStatusToRead({
    this.dateStart,
    this.sendNotification,
  });

  factory BookStatusToRead.fromJson(Map<String, dynamic> json) =>
      _$BookStatusToReadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusToReadToJson(this);
}
