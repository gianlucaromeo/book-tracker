import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BooksRepository {
  static addBook(BookModel book) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reference to document
      final docUser =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      docUser.collection('books').doc(book.bookData.id).set(book.toJson());
      //print('Add book ${book.bookData.toJson().toString()}');
    }
  }
}
