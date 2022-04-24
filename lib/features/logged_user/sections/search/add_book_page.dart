import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/add_book_status_page.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';

class AddBookPage extends StatefulWidget {
  final GoogleBookModel googleBookModel;
  const AddBookPage({Key? key, required this.googleBookModel})
      : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // BACKGROUND
            Container(
              height: 250.0,
              color: themeController.currentThemeData.colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.defaultPadding,
                right: AppPadding.defaultPadding,
                top: AppPadding.defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GO BACK ICON
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TransparentDivider.h(50.0),
                  // TITLE, AUTHORS AND BOOK IMAGE
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.defaultPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE AND AUTHORS
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TITLE
                              buildBookTitle(),
                              // AUTHORS
                              buildBookAuthors(),
                            ],
                          ),
                        ),
                        TransparentDivider.w(20.0),
                        // IMAGE
                        buildImageContainer(),
                      ],
                    ),
                  ),
                  // DESCRIPTION
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: AppPadding.defaultPadding),
                      child: buildDescription(),
                    ),
                  ),
                  TransparentDivider.h(20.0),
                  // PAGES, STARS, LANGUAGE
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.defaultPadding),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                            AppBorders.defaultBorderRadius),
                      ),
                      padding:
                          const EdgeInsets.all(AppPadding.defaultPadding / 2),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // PAGES
                            buildGenericBookInfo(
                              widget.googleBookModel.volumeInfo?.pageCount
                                      ?.toString() ??
                                  '',
                              'Pages',
                            ),
                            TransparentDivider.w(15.0),
                            buildRatingStars(),
                            TransparentDivider.w(15.0),
                            // LANGUAGE
                            buildGenericBookInfo(
                              widget.googleBookModel.volumeInfo?.language
                                      ?.toString()
                                      .toUpperCase() ??
                                  '',
                              'Language',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // BUTTONS
                  buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildActionButtons() {
    const opacity = 0.6;
    final buttonsData = [
      [
        Icons.done,
        "Read",
        Colors.green.withOpacity(opacity),
        BookStatusRead(),
      ], // READ
      [
        Icons.timelapse,
        "Currently reading",
        Colors.orange.withOpacity(opacity),
        BookStatusCurrentlyReading(),
      ], // CURRENTLY READING
      [
        Icons.calendar_today,
        "To read",
        Colors.pink.withOpacity(opacity),
        BookStatusToRead(),
      ], // TO READ
    ];

    return Padding(
      padding: const EdgeInsets.all(AppPadding.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 3; i++)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRect(
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppBorders.defaultBorderRadius)),
                    color: buttonsData[i][2] as Color,
                    child: InkWell(
                      //splashColor: Colors.green, // splash color
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddBookStatusPage(
                            googleBookModel: widget.googleBookModel,
                            bookStatus: buttonsData[i][3] as BookStatus,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              buttonsData[i][0] as IconData,
                              size: 50.0,
                              color: Colors.white,
                            ), // icon
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TransparentDivider.h(5.0),
                Text(
                  buttonsData[i][1] as String,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  buildDescription() {
    String? description = widget.googleBookModel.volumeInfo?.description;
    if (description != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TransparentDivider.h(15.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                description,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      );
    } else {
      return Text(
        "No Description",
      );
    }
  }

  buildRatingStars() {
    num? rating = widget.googleBookModel.volumeInfo?.averageRating;
    if (rating != null) {
      return Row(
        children: [
          for (int i = 1; i <= 5; i++)
            if (i <= rating)
              Icon(
                Icons.star,
                color: Colors.orange,
              )
            else
              Icon(Icons.star)
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextButton.icon(
          icon: Icon(Icons.info),
          label: Text(
            'Info',
            style: TextStyle(fontSize: 21.0),
          ),
          onPressed: () {},
        ),
      );
    }
  }

  Column buildGenericBookInfo(String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }

  Text buildBookTitle() {
    return Text(
      widget.googleBookModel.volumeInfo?.title ?? 'No Title',
      maxLines: 2,
      style: const TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
        color: Colors.white,
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
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    );
  }

  Container buildImageContainer() {
    return Container(
      width: 130,
      height: 190,
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
