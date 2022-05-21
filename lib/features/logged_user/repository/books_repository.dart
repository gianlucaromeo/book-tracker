import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/book_status_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef Json = Map<String, dynamic>;

class BooksRepository {
  static const _usersCollectionPath = 'users';

  static Future<int> _getLibraryCollectionLength(
      {required BookStatusType type}) async {
    User user = FirebaseAuth.instance.currentUser!;
    return await FirebaseFirestore.instance
        .collection(_usersCollectionPath)
        .doc(user.uid)
        .collection(type.name)
        .get()
        .then((snap) => snap.size);
  }

  static Stream<QuerySnapshot> _getLibraryStream(
      {required BookStatusType type}) {
    User user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection(_usersCollectionPath)
        .doc(user.uid)
        .collection(type.name)
        .snapshots();
  }

  static Future _deleteBookFromCollectionPath(
      {required String path, required String bookId}) {
    User user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection(_usersCollectionPath)
        .doc(user.uid)
        .collection(path)
        .doc(bookId)
        .delete();
  }

  // Books Read
  static Stream<QuerySnapshot> booksReadStream() =>
      _getLibraryStream(type: BookStatusType.read);

  // Books Currently Reading
  static Stream<QuerySnapshot> booksCurrentlyReadingStream() =>
      _getLibraryStream(type: BookStatusType.currentlyReading);

  // Books To Read
  static Stream<QuerySnapshot> booksToReadStream() =>
      _getLibraryStream(type: BookStatusType.toRead);

  static Future addBook(BookModel bookModel) {
    User user = FirebaseAuth.instance.currentUser!;
    // Based on the BookStatus type.
    // Find BookStatus type to use as the name of the collection
    String collectionPath = BookStatusUtil.getStatusTypeNameFromStatus(
      bookModel.bookStatus,
    );

    // Add book to User's collection
    return FirebaseFirestore.instance
        .collection(_usersCollectionPath)
        .doc(user.uid)
        .collection(collectionPath)
        .doc(bookModel.bookData.id)
        .set(bookModel.toJson());
  }

  static Future deleteBookFromBookModel(BookModel bookModel) {
    final String collectionPath =
        BookStatusUtil.getStatusTypeNameFromStatus(bookModel.bookStatus);
    return _deleteBookFromCollectionPath(
        path: collectionPath, bookId: bookModel.bookData.id!);
  }

  static Future updateBook(
    BookModel bookModel,
    BookStatus oldBookStatus,
  ) {
    final String oldCollectionPath =
        BookStatusUtil.getStatusTypeNameFromStatus(oldBookStatus);
    final String newCollectionPath =
        BookStatusUtil.getStatusTypeNameFromStatus(bookModel.bookStatus);
    if (oldCollectionPath != newCollectionPath) {
      _deleteBookFromCollectionPath(
        bookId: bookModel.bookData.id!,
        path: oldCollectionPath,
      );
    }
    // Updates if exists or adds it if not
    return addBook(bookModel);
  }

  static Future<int> booksReadLength() =>
      _getLibraryCollectionLength(type: BookStatusType.read);

  static Future<int> booksCurrentlyReadingLength() =>
      _getLibraryCollectionLength(type: BookStatusType.currentlyReading);

  static Future<int> booksToReadLength() =>
      _getLibraryCollectionLength(type: BookStatusType.toRead);

  // ! TODO
  static Future<bool> _bookExists(BookStatusType type, String bookId) {
    User user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection(_usersCollectionPath)
        .doc(user.uid)
        .collection(type.name)
        .doc(bookId)
        .get()
        .then((snap) => snap.exists);
  }

  static Future<bool> bookReadExist(String bookId) =>
      _bookExists(BookStatusType.read, bookId);

  static Future<bool> bookCurrentlyReadingExist(String bookId) =>
      _bookExists(BookStatusType.currentlyReading, bookId);

  static Future<bool> bookToReadExist(String bookId) =>
      _bookExists(BookStatusType.toRead, bookId);

  static Future<Json> findBookStatusJson(
      BookStatusType type, String bookId) async {
    User user = FirebaseAuth.instance.currentUser!;
    return await FirebaseFirestore.instance
        .collection(_usersCollectionPath)
        .doc(user.uid)
        .collection(type.name)
        .doc(bookId)
        .get()
        .then((docSnap) => docSnap.data()!['bookStatus'] as Json);
  }
}
