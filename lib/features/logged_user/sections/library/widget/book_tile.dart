import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
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
        Expanded(
          child: Column(
            children: [
              Text(bookModel.bookData.volumeInfo?.title ?? ''),
              Text(bookModel.bookData.volumeInfo?.authorsAsString ?? ''),
            ],
          ),
        ),
      ],
    );
  }
}

class BookTile extends StatefulWidget {
  final BookModel bookModel;
  final Widget body;

  const BookTile({Key? key, required this.bookModel, required this.body})
      : super(key: key);

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  late final IconButton arrowIcon;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    arrowIcon = IconButton(
      icon: const Icon(Icons.arrow_drop_down_rounded),
      onPressed: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // HEADER + ICON
          Row(
            children: [
              Expanded(child: BookTileHeader(bookModel: widget.bookModel)),
              arrowIcon,
            ],
          ),
          if (isExpanded) widget.body
        ],
      ),
    );
  }
}
