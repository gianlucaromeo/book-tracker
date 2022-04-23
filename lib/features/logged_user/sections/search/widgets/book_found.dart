import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
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

  //final booksStatusTypes = BookStatusType.values.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
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
                  icon: const Icon(
                    Icons.arrow_right,
                    size: 40.0,
                  ),
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
        padding:
            const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBookTitle(),
            buildBookAuthors(),
            if (widget.googleBookModel.volumeInfo?.averageRating != null)
              Icon(Icons.star)
          ],
        ),
      ),
    );
  }

  Text buildBookAuthors() {
    String authors = '';
    final bookAuthors = widget.googleBookModel.volumeInfo?.authors;
    if (bookAuthors != null) {
      for (int i = 0; i < bookAuthors.length; i++) {
        final currentAuthor = bookAuthors[i];
        if (i != bookAuthors.length - 2 && i != 0) {
          authors += ', ';
        }
        authors += currentAuthor;
      }
    }
    return Text(
      authors,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    );
  }

  Text buildBookTitle() {
    return Text(
      widget.googleBookModel.volumeInfo?.title ?? 'NO TITLE',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 19.0,
      ),
    );
  }

  Container buildImageContainer() {
    return Container(
      width: 80,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius / 2),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            offset: const Offset(5, 5),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius / 2),
        child: Image.network(
          widget.googleBookModel.volumeInfo?.imageUrl ??
              'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
