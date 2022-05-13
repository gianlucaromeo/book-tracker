import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/searched_book_page.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookFoundTile extends StatefulWidget {
  late final GoogleBookModel googleBookModel;

  BookFoundTile({Key? key, required GoogleBookModel book}) : super(key: key) {
    googleBookModel = book;
  }

  @override
  _BookFoundTileState createState() => _BookFoundTileState();
}

class _BookFoundTileState extends State<BookFoundTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                // BOOK IMAGE
                BookImage(
                  size: BookImageSize.bookFindTile,
                  imageUrl:
                      widget.googleBookModel.volumeInfo?.imageLinks!.thumbnail,
                ),
                // TITLE AND AUTHORS
                buildTitleAndAuthors(),
                // GO TO BOOK ARROW ICON BUTTON
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchedBookPage(
                        googleBookModel: widget.googleBookModel,
                        updateStatus: false,
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 35.0,
                    color: themeController.currentThemeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildTitleAndAuthors() {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBookTitle(),
            TransparentDivider.h(5.0),
            buildBookAuthors(),
          ],
        ),
      ),
    );
  }

  Text buildBookAuthors() {
    return Text(
      widget.googleBookModel.volumeInfo?.authorsAsString ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
    );
  }

  Text buildBookTitle() {
    return Text(
      widget.googleBookModel.volumeInfo?.title ?? 'No title',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
