import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_status_will_never_read.g.dart';

@JsonSerializable()
class BookStatusWillNeverRead extends BookStatus {
  final String status = "willNeverRead";
  List<String>? reasons;
  List<String>? comments;

  BookStatusWillNeverRead({
    this.reasons,
    this.comments,
  });

  factory BookStatusWillNeverRead.fromJson(Map<String, dynamic> json) =>
      _$BookStatusWillNeverReadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusWillNeverReadToJson(this);
}
