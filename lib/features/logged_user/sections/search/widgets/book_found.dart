import 'package:book_tracker/features/logged_user/models/google_book.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookFound extends StatefulWidget {
  late final GoogleBookModel _book;

  BookFound({Key? key, required GoogleBookModel book}) : super(key: key) {
    _book = book;
  }

  @override
  _BookFoundState createState() => _BookFoundState();
}

class _BookFoundState extends State<BookFound> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // -- Book Image
            buildImageContainer(),
            // -- Title and Author
            buildListTileTitleAndAuthor(),
            // -- Action Button
            buildListTileButton(context)
          ],
        ),
      ),
    );
  }

  Container buildListTileButton(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: IconButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50.0),
            ),
          ),
          builder: (context) => buildSheet(),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Expanded buildListTileTitleAndAuthor() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBookTitle(),
            buildBookAuthors(),
          ],
        ),
      ),
    );
  }

  Text buildBookAuthors() {
    return Text(
      widget._book.authors.toString(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text buildBookTitle() {
    return Text(
      widget._book.title ?? 'NO TITLE',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    );
  }

  Container buildImageContainer() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Image.network(
        widget._book.imageUrl ??
            'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
        width: 70,
        height: 100,
      ),
    );
  }

  Widget buildSheet() => Container(
        padding: const EdgeInsets.all(20.0),
        //height: MediaQuery.of(context).size.height - 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildImageContainer(),
            TransparentDivider.h(20.0),
            buildBookTitle(),
            TransparentDivider.h(6.0),
            buildBookAuthors(),
            Text(widget._book.toString()),
            TransparentDivider.h(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: OutlinedButton(
                onPressed: _addBookToUserCollection,
                child: const Text('Aggiungi alla libreria'),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                ),
              ),
            )
          ],
        ),
      );

  Future _addBookToUserCollection() async {
    final books = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');
    await books.add(widget._book.toJson());
  }
}
