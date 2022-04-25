import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';

class BookStatusUtil {
  /// Binds a BookStatusType to an index, in order
  /// to follow an order for Buttons, Lists, Pages, ...
  static const bookStatusIndexes = {
    BookStatusType.read: 0,
    BookStatusType.currentlyReading: 1,
    BookStatusType.toRead: 2,
  };

  static getIndex(BookStatus bookStatus) {
    if (bookStatus is BookStatusRead) {
      return bookStatusIndexes[BookStatusType.read]!;
    } else if (bookStatus is BookStatusCurrentlyReading) {
      return bookStatusIndexes[BookStatusType.currentlyReading]!;
    }
    return bookStatusIndexes[BookStatusType.toRead]!;
  }
}
