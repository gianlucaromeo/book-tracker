import 'package:book_tracker/features/logged_user/models/books_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book.dart';

class UserBookModel {
  final GoogleBookModel googleBookModel;
  BookStatus bookStatus = StatusNone();

  UserBookModel.noStatus(this.googleBookModel);
  UserBookModel.withStatus(this.googleBookModel, this.bookStatus);
}
