import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookModel {
  /// A few data fetched from the Google Book API.
  late final GoogleBookModel bookData;

  /// The status of this book for the reader:
  /// - Read
  /// - ToRead
  /// - CurrentlyReading
  late BookStatus bookStatus;

  BookModel({required this.bookData, required this.bookStatus});

  BookModel.statusNone({required this.bookData}) {
    bookStatus = BookStatus();
  }

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
