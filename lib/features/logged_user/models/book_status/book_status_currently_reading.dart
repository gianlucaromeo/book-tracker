import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_status_currently_reading.g.dart';

@JsonSerializable()
class BookStatusCurrentlyReading extends BookStatus {
  final String status = "currentlyReading";
  DateTime? dateStart;
  List<String>? comments;
  List<int>? savedPages;

  BookStatusCurrentlyReading({
    this.dateStart,
    this.comments,
    this.savedPages,
  });

  factory BookStatusCurrentlyReading.fromJson(Map<String, dynamic> json) =>
      _$BookStatusCurrentlyReadingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusCurrentlyReadingToJson(this);
}
