import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/add_status_button.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/cancel_status_button.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/set_book_status_container.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class SearchedBookPage extends StatefulWidget {
  final GoogleBookModel googleBookModel;
  const SearchedBookPage({Key? key, required this.googleBookModel})
      : super(key: key);

  @override
  State<SearchedBookPage> createState() => _SearchedBookPageState();
}

class _SearchedBookPageState extends State<SearchedBookPage> {
  bool addStatus = false;

  void toggleAddStatus() {
    setState(() {
      addStatus = !addStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // BACKGROUND
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                color: themeController.isDarkTheme
                    ? DarkThemeData.surface
                    : LightThemeData.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppBorders.defaultBorderRadius),
                  bottomRight: Radius.circular(AppBorders.defaultBorderRadius),
                ),
              ),
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
                    child: buildBookTitleAuthorsAndImage(),
                  ),
                  TransparentDivider.h(AppPadding.defaultPadding),

                  addStatus ? buildStatusForm() : buildBookInfo(),

                  TransparentDivider.h(AppPadding.defaultPadding / 2),

                  // ADD STATUS BUTTON
                  addStatus
                      ? buildCancelStatusButton()
                      : buildAddStatusButton(),
                  /*
                  // BUTTONS
                  Padding(
                    padding:
                        const EdgeInsets.all(AppPadding.defaultPadding / 2),
                    child: AddStatusActionButtons(
                      googleBookModel: widget.googleBookModel,
                    ),
                  ),
                  */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildAddStatusButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.defaultPadding / 2),
      child: AddStatusButton(onPressed: toggleAddStatus),
    );
  }

  buildCancelStatusButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.defaultPadding / 2),
      child: CancelStatusButton(onPressed: toggleAddStatus),
    );
  }

  buildBookInfo() {
    return Expanded(
      child: Column(
        children: [
          // PAGES, STARS, LANGUAGE
          buildGenericInfoContainer(),
          // DESCRIPTION
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.defaultPadding,
              ),
              child: buildDescription(),
            ),
          ),
          TransparentDivider.h(20.0),
        ],
      ),
    );
  }

  buildStatusForm() {
    return Expanded(
      child: SetBookStatusContainer(
        googleBookModel: widget.googleBookModel,
        bookStatus: BookStatusCurrentlyReading(),
      ),
    );
  }

  buildBookTitleAuthorsAndImage() {
    return Row(
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
        BookImage(
          size: BookImageSize.searchedBook,
          imageUrl: widget.googleBookModel.volumeInfo?.imageLinks!.thumbnail,
        ),
      ],
    );
  }

  buildGenericInfoContainer() {
    final opacity = themeController.isDarkTheme ? 0.0 : 0.1;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(opacity),
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
        border: themeController.isDarkTheme
            ? Border.all(color: Theme.of(context).colorScheme.surface)
            : null,
      ),
      padding: const EdgeInsets.all(5.0),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // PAGES
            buildGenericBookInfo(
              widget.googleBookModel.volumeInfo?.pageCount?.toString() ?? '',
              'Pages',
            ),
            TransparentDivider.w(15.0),
            // RATING STARS or INFO LINK
            buildRatingStarsOrInfoLink(),
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
    );
  }

  buildDescription() {
    String? description = widget.googleBookModel.volumeInfo?.description;
    if (description != null) {
      final opacity = themeController.isDarkTheme ? 0.6 : 1.0;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: Theme.of(context).textTheme.headlineSmall),
          TransparentDivider.h(15.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .color!
                      .withOpacity(opacity),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Text(
        "No Description",
      );
    }
  }

  buildRatingStarsOrInfoLink() {
    num? rating = widget.googleBookModel.volumeInfo?.averageRating;
    if (rating != null) {
      return buildRatingStarsIcons(rating);
    } else {
      return buildBookInfoLink();
    }
  }

  Padding buildBookInfoLink() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextButton.icon(
        icon: const Icon(Icons.info),
        label: Text(
          'Info',
          style: TextStyle(
            fontSize: 21.0,
            color: themeController.isDarkTheme
                ? Colors.white
                : LightThemeData.primary,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Row buildRatingStarsIcons(num rating) {
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          if (i <= rating)
            Icon(
              Icons.star,
              color: themeController.currentThemeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            )
          else
            const Icon(Icons.star, color: Colors.grey)
      ],
    );
  }

  Column buildGenericBookInfo(String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
            color:
                Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Text buildBookTitle() {
    return Text(
      widget.googleBookModel.volumeInfo?.title ?? 'No Title',
      maxLines: 2,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        overflow: TextOverflow.ellipsis,
        color: themeController.currentThemeMode == ThemeMode.dark
            ? DarkThemeData.searchedBookPageBookTitle
            : LightThemeData.searchedBookPageBookTitle,
      ),
    );
  }

  Text buildBookAuthors() {
    return Text(
      widget.googleBookModel.volumeInfo?.authorsAsString ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: themeController.currentThemeMode == ThemeMode.dark
            ? DarkThemeData.searchedBookPageBookAuthors
            : LightThemeData.searchedBookPageBookAuthors,
        fontWeight: FontWeight.w500,
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
      ),
    );
  }
}
