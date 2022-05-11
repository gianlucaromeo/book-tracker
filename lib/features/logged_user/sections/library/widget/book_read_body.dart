import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/date_info_uneditable.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/rating_info_uneditable.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

/// Body
class BookReadBody extends StatefulWidget {
  BookModel bookModel;
  BookReadBody({Key? key, required this.bookModel}) : super(key: key);

  @override
  State<BookReadBody> createState() => _BookReadBodyState();
}

class _BookReadBodyState extends State<BookReadBody> {
  late BookStatusRead bookStatusRead;

  @override
  void initState() {
    super.initState();
    bookStatusRead =
        BookStatusRead.fromJson(widget.bookModel.bookStatus.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: AppPadding.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (bookStatusRead.dateStart != null)
              DateInfoUneditable(
                dateTime: bookStatusRead.dateStart!,
              ),
            TransparentDivider.w(AppPadding.defaultPadding),
            if (bookStatusRead.rating != null)
              RatingInfoUneditable(rating: bookStatusRead.rating!)
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TransparentDivider.h(10),
          buildFinishedButton(),
        ],
      ),
      // trailing: Icon(Icons.edit),
    );
  }

  buildFinishedButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text(
        'Finished!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 19.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: themeController.isDarkTheme
            ? DarkThemeData.onPrimary
            : LightThemeData.primary,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 40),
        maximumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppBorders.defaultBorderRadius / 2,
          ),
        ),
      ),
    );
  }
}
