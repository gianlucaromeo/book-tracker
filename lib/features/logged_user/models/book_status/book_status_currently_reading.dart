import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_status_currently_reading.g.dart';

@JsonSerializable()
class BookStatusCurrentlyReading extends BookStatus {
  final BookStatusType type = BookStatusType.currentlyReading;
  DateTime? dateStart;
  int? rating; // 1 to 5
  String? comment;
  bool? liked;

  BookStatusCurrentlyReading({
    this.dateStart,
    this.rating,
    this.comment,
    this.liked,
  });

  factory BookStatusCurrentlyReading.fromJson(Map<String, dynamic> json) =>
      _$BookStatusCurrentlyReadingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusCurrentlyReadingToJson(this);
}
