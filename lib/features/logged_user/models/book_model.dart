import 'package:book_tracker/features/logged_user/models/books_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';

// explicitToJson: True --> If nested json inside
class BookModel {
  /// A few data fetched from the Google Book API.
  late final GoogleBookModel bookData;

  /// The status of this book for the reader:
  /// - Read
  /// - ToRead
  /// - ReadButNotLike
  /// - CurrentlyReading
  /// - WillNeverRead
  /// - None
  late BookStatus bookStatus;

  BookModel({required this.bookData, required this.bookStatus});

  BookModel.statusNone({required this.bookData}) {
    bookStatus = BookStatusNone();
  }

  Json toJson() => {
        "bookData": bookData.toJson(),
        "bookStatus": bookStatus.toJson(),
      };
}
