import 'package:book_tracker/features/logged_user/data/book_status_data.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/add_book_page.dart';
import 'package:flutter/material.dart';

class BookFound extends StatefulWidget {
  late final GoogleBookModel googleBookModel;

  BookFound({Key? key, required GoogleBookModel book}) : super(key: key) {
    googleBookModel = book;
  }

  @override
  _BookFoundState createState() => _BookFoundState();
}

class _BookFoundState extends State<BookFound> {
  bool showActions = false;
  toggleShowActions() {
    showActions = !showActions;
    setState(() {});
  }

  final booksStatusTypes = BookStatusType.values.toList();

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
      //width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                // BOOK IMAGE
                buildImageContainer(),
                // TITLE AND AUTHORS
                buildListTileTitleAndAuthor(),
                // ADD BOOK BUTTON
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AddBookPage(googleBookModel: widget.googleBookModel),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
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
      widget.googleBookModel.volumeInfo?.authors?.toString() ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text buildBookTitle() {
    return Text(
      widget.googleBookModel.volumeInfo?.title ?? 'NO TITLE',
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
        widget.googleBookModel.volumeInfo?.imageUrl ??
            'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
        width: 70,
        height: 100,
      ),
    );
  }
}
