import 'package:json_annotation/json_annotation.dart';

import 'book_status.dart';

part 'book_status_read.g.dart';

@JsonSerializable()
class BookStatusRead extends BookStatus {
  final String status = "read";
  DateTime? dateStart;
  DateTime? dateEnd;
  int? rating; // 1 to 5
  List<String>? comments;
  List<int>? savedPages;

  // ! TODO : Add Like/Dislike

  BookStatusRead({
    this.dateStart,
    this.dateEnd,
    this.rating,
    this.comments,
    this.savedPages,
  });

  factory BookStatusRead.fromJson(Map<String, dynamic> json) =>
      _$BookStatusReadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusReadToJson(this);
}
