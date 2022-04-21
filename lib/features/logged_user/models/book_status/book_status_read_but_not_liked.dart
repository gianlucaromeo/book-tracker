import 'package:json_annotation/json_annotation.dart';

import 'book_status.dart';

part 'book_status_read_but_not_liked.g.dart';

@JsonSerializable()
class BookStatusReadButNotLiked extends BookStatus {
  final String status = "readButNotLiked";
  DateTime? dateStart;
  DateTime? dateEnd;
  List<String>? reasons;
  List<String>? comments;

  BookStatusReadButNotLiked({
    this.dateStart,
    this.dateEnd,
    this.reasons,
    this.comments,
  });

  factory BookStatusReadButNotLiked.fromJson(Map<String, dynamic> json) =>
      _$BookStatusReadButNotLikedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BookStatusReadButNotLikedToJson(this);
}
