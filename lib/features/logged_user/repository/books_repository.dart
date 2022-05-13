import 'dart:convert';

import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/book_status_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/books_search_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef Json = Map<String, dynamic>;

class BooksRepository {
  static const usersCollectionPath = 'users';

  // BOOKS READ
  static Stream<QuerySnapshot> booksReadStream() {
    User user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection(usersCollectionPath)
        .doc(user.uid)
        .collection(BookStatusType.read.name)
        .snapshots();
  }

  // BOOKS CURRENTLY READING
  static Stream<QuerySnapshot> booksCurrentlyReadingStream() {
    User user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection(usersCollectionPath)
        .doc(user.uid)
        .collection(BookStatusType.currentlyReading.name)
        .snapshots();
  }

  // BOOKS TO READ
  static Stream<QuerySnapshot> booksToReadStream() {
    User user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection(usersCollectionPath)
        .doc(user.uid)
        .collection(BookStatusType.toRead.name)
        .snapshots();
  }

  static addBook(BookModel bookModel) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Based on the BookStatus type.
      // Find BookStatus type to use as the name of the collection
      String collectionPath =
          BookStatusUtil.getStatusTypeNameFromStatus(bookModel.bookStatus);

      // Add book to User's collection
      FirebaseFirestore.instance
          .collection(usersCollectionPath)
          .doc(user.uid)
          .collection(collectionPath)
          .doc(bookModel.bookData.id)
          .set(bookModel.toJson());
    }
  }

  // ! TODO
  static Stream<QuerySnapshot> globalPopularBooks() {
    // RANDOM BOOKS TO ADD
    BookSearchUtil.findNRandomBooks().then((googleBooks) {
      for (int i = 0; i < 4; i++) {
        final googleBookJson = jsonDecode(googleBooks.body)['items'][i];
        final googleBookModel = GoogleBookModel.fromJson(googleBookJson);
        FirebaseFirestore.instance
            .collection('global_popular_books')
            .doc(googleBookModel.id)
            .set(googleBookModel.toJson());
      }
    });

    return FirebaseFirestore.instance
        .collection('global_popular_books')
        .snapshots();
  }

  static Stream<QuerySnapshot> globalDiscoverBooks() {
    // RANDOM BOOKS TO ADD
    BookSearchUtil.findNRandomBooks(bookToFind: 'dietro', n: 6)
        .then((googleBooks) {
      for (int i = 0; i < 3; i++) {
        final googleBookJson = jsonDecode(googleBooks.body)['items'][i];
        final googleBookModel = GoogleBookModel.fromJson(googleBookJson);
        FirebaseFirestore.instance
            .collection('global_discover_books')
            .get()
            .then((snap) {
          if (snap.size < 3) {
            FirebaseFirestore.instance
                .collection('global_discover_books')
                .doc(googleBookModel.id)
                .set(googleBookModel.toJson());
          }
        });
      }
    });

    return FirebaseFirestore.instance
        .collection('global_discover_books')
        .snapshots();
  }

  static deleteBookFromCollectionName(
      BookModel bookModel, String oldCollectionPath) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Remove book data
      FirebaseFirestore.instance
          .collection(usersCollectionPath)
          .doc(user.uid)
          .collection(oldCollectionPath)
          .doc(bookModel.bookData.id)
          .delete();
    }
  }

  static void updateBook(BookModel bookModel, BookStatus oldBookStatus) {
    final String oldCollectionPath =
        BookStatusUtil.getStatusTypeNameFromStatus(oldBookStatus);
    final String newCollectionPath =
        BookStatusUtil.getStatusTypeNameFromStatus(bookModel.bookStatus);
    if (oldCollectionPath != newCollectionPath) {
      deleteBookFromCollectionName(bookModel, oldCollectionPath);
    }
    // Updates if exists or adds it if not
    addBook(bookModel);
  }

  static void deleteBookFromBookModel(BookModel bookModel) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String collectionPath =
          BookStatusUtil.getStatusTypeNameFromStatus(bookModel.bookStatus);
      FirebaseFirestore.instance
          .collection(usersCollectionPath)
          .doc(user.uid)
          .collection(collectionPath)
          .doc(bookModel.bookData.id)
          .delete();
    }
  }
}
