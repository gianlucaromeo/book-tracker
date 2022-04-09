import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_input_containers/book_read_input.dart';
import 'package:book_tracker/util/transparent_divider.dart';
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
  bool showActions = false;
  toggleShowActions() {
    showActions = !showActions;
    setState(() {});
  }

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
                // -- Book Image
                buildImageContainer(),
                // -- Title and Author
                buildListTileTitleAndAuthor(),
                // -- Action Button
                buildListTileButton(context)
              ],
            ),
            if (showActions)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 2; i++)
                    // ADD READ BUTTON
                    OutlinedButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50.0),
                          ),
                        ),
                        builder: (context) => buildSheet(),
                      ), //_addBookStatusRead,
                      child: const Text('Already Read'),
                      style: ElevatedButton.styleFrom(
                        elevation: 2.0,
                      ),
                    ),
                ],
              ),
            if (showActions)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 2; i++)
                    // ADD READ BUTTON
                    OutlinedButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50.0),
                          ),
                        ),
                        builder: (context) => buildSheet(),
                      ), //_addBookStatusRead,
                      child: const Text('Already Read'),
                      style: ElevatedButton.styleFrom(
                        elevation: 2.0,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Container buildListTileButton(BuildContext context) {
    return Container(
      width: 50,
      child: IconButton(
        onPressed: () => toggleShowActions(),
        icon: showActions
            ? const Icon(Icons.arrow_drop_up)
            : const Icon(Icons.arrow_drop_down),
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
            // * Add the right container from the user choice.
            // ! Change
            BookReadInputContainer(bookData: widget._book),
          ],
        ),
      );
}
