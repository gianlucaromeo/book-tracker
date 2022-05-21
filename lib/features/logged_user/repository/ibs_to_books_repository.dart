import 'dart:convert';

import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/books_search_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import 'ibs_urls.dart' as urls;

class IBSToBooksRepository {
  static const _isbnLength = 13;
  static Stream<QuerySnapshot> _getStream({
    required String url,
    required int maxBooks,
    required String collectionPath,
  }) {
    http.get(Uri.parse(url)).then((response) {
      dom.Document html = dom.Document.html(response.body);

      final links = html
          .querySelectorAll(
              'div.cc-item-row > div.cc-col-info > div.cc-content-text > div.cc-content-title > a')
          .map((e) => '${urls.ibsURL}${e.attributes['href']}')
          .toList();

      for (int i = 0; i < maxBooks; i++) {
        String link = links[i];
        final isbn = link.substring(link.length - _isbnLength, link.length);

        BookSearchUtil.findNBooks(bookToFind: isbn, n: 1).then((googleBooks) {
          final googleBookJson = jsonDecode(googleBooks.body)['items'][0];
          final googleBookModel = GoogleBookModel.fromJson(googleBookJson);
          FirebaseFirestore.instance
              .collection(collectionPath)
              .get()
              .then((snap) {
            if (snap.size < maxBooks) {
              FirebaseFirestore.instance
                  .collection(collectionPath)
                  .doc(googleBookModel.id)
                  .set(googleBookModel.toJson());
            }
          });
        });
      }
    });
    return FirebaseFirestore.instance.collection(collectionPath).snapshots();
  }

  // Most sold books (from IBS webiste)
  static Stream<QuerySnapshot> mostSoldBooks() {
    return _getStream(
      url: urls.mostSoldURL,
      maxBooks: 15,
      collectionPath: 'global_most_sold_books',
    );
  }

  // Most reviewed books (from IBS webiste)
  static Stream<QuerySnapshot> mostReviewedBooks() {
    return _getStream(
      url: urls.mostReviewedURL,
      maxBooks: 15,
      collectionPath: 'global_most_reviewed_books',
    );
  }

  // Most gifted books (from IBS webiste)
  static Stream<QuerySnapshot> mostGiftedBooks() {
    return _getStream(
      url: urls.mostGiftedURL,
      maxBooks: 5,
      collectionPath: 'global_most_gifted_books',
    );
  }

  static Stream<QuerySnapshot> bookOfTheDay() {
    return _getStream(
      url: urls.mostGiftedURL,
      maxBooks: 1,
      collectionPath: 'global_most_reviewed_books',
    );
  }
}
