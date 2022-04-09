import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BooksRepository {
  static addBook(BookModel book) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Add book $book');
    }
  }
}
