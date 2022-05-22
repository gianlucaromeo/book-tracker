import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/searched_book_page.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/custom_page_route.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookTileHeader extends StatelessWidget {
  final GoogleBookModel googleBookModel;
  const BookTileHeader({Key? key, required this.googleBookModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BookImage(
          imageUrl: googleBookModel.volumeInfo?.imageLinks?.thumbnail ?? '',
          size: BookImageSize.bookFindTile,
        ),
        TransparentDivider.w(AppPadding.defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                googleBookModel.volumeInfo?.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                googleBookModel.volumeInfo?.authorsAsString ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
              buildCategories(context),
            ],
          ),
        ),
        TransparentDivider.w(10),
      ],
    );
  }

  buildCategories(BuildContext context) {
    final String categories = googleBookModel.volumeInfo!.categoriessAsString;
    if (categories != '') {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2),
          child: Text(
            categories,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return TransparentDivider.h(0.0);
    }
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
      icon: Icon(
        Icons.keyboard_arrow_right_rounded,
        size: 35.0,
        color: themeController.currentThemeMode == ThemeMode.dark
            ? Colors.white
            : Colors.black,
      ),
      onPressed: () => Navigator.of(context).push(
        CustomPageRoute(
          child: SearchedBookPage(
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // HEADER + ICON
            Row(
              children: [
                Expanded(
                    child: BookTileHeader(
                        googleBookModel: widget.bookModel.bookData)),
                arrowIcon,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
