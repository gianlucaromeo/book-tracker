import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/searched_book_page.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookTileHeader extends StatelessWidget {
  final BookModel bookModel;
  const BookTileHeader({Key? key, required this.bookModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BookImage(
          imageUrl: bookModel.bookData.volumeInfo?.imageLinks?.thumbnail ?? '',
          size: BookImageSize.bookFindTile,
        ),
        TransparentDivider.w(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookModel.bookData.volumeInfo?.title ?? '',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                bookModel.bookData.volumeInfo?.authorsAsString ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
            ],
          ),
        ),
        TransparentDivider.w(10),
      ],
    );
  }
}

class BookTile extends StatefulWidget {
  final BookModel bookModel;

  const BookTile({Key? key, required this.bookModel}) : super(key: key);

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  late final IconButton arrowIcon;

  @override
  void initState() {
    super.initState();
    arrowIcon = IconButton(
      icon: const Icon(Icons.arrow_right_outlined),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchedBookPage(
            googleBookModel: widget.bookModel.bookData,
            updateStatus: true,
            bookStatus: widget.bookModel.bookStatus,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // HEADER + ICON
            Row(
              children: [
                Expanded(child: BookTileHeader(bookModel: widget.bookModel)),
                arrowIcon,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
