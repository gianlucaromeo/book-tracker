// ignore_for_file: must_be_immutable

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/add_status_button.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/no_description_info.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/set_book_status_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/show_book_page_button.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchedBookPage extends StatefulWidget {
  final bool updateStatus;

  BookStatus? bookStatus; // null id updateStatus is false
  final GoogleBookModel googleBookModel;

  SearchedBookPage({
    Key? key,
    required this.googleBookModel,
    required this.updateStatus,
    this.bookStatus,
  }) : super(key: key);

  @override
  State<SearchedBookPage> createState() => _SearchedBookPageState();
}

class _SearchedBookPageState extends State<SearchedBookPage> {
  late bool updateStatus;
  late bool bookIsInLibrary = false;
  late AppLocalizations l10n;

  @override
  void initState() {
    super.initState();
    updateStatus = widget.updateStatus;
  }

  void toggleAddStatus() {
    setState(() {
      updateStatus = !updateStatus;
    });
  }

  Future<bool> _checkBookAlreadyInLibrary() async {
    if (!updateStatus) {
      String bookId = widget.googleBookModel.id!;
      final bool read = await BooksRepository.bookReadExist(bookId);
      if (read) {
        await BooksRepository.findBookStatusJson(BookStatusType.read, bookId)
            .then((bookModelJson) =>
                widget.bookStatus = BookStatusRead.fromJson(bookModelJson));
        bookIsInLibrary = true;
      } else {
        final bool currentlyReading =
            await BooksRepository.bookCurrentlyReadingExist(bookId);
        if (currentlyReading) {
          await BooksRepository.findBookStatusJson(
                  BookStatusType.currentlyReading, bookId)
              .then((bookModelJson) => widget.bookStatus =
                  BookStatusCurrentlyReading.fromJson(bookModelJson));
          bookIsInLibrary = true;
        } else {
          final bool toRead = await BooksRepository.bookToReadExist(bookId);
          if (toRead) {
            await BooksRepository.findBookStatusJson(
                    BookStatusType.toRead, bookId)
                .then((bookModelJson) => widget.bookStatus =
                    BookStatusToRead.fromJson(bookModelJson));
            bookIsInLibrary = true;
          }
        }
      }
    }
    return bookIsInLibrary;
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // BACKGROUND
            Container(
              height: 185.0,
              decoration: BoxDecoration(
                color: themeController.isDarkTheme
                    ? DarkThemeData.secondary
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
              child: FutureBuilder<bool>(
                  future: _checkBookAlreadyInLibrary(),
                  builder: (context, snap) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GO BACK ICON
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        TransparentDivider.h(AppPadding.defaultPadding),
                        // TITLE, AUTHORS AND BOOK IMAGE
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.defaultPadding),
                          child: buildBookTitleAuthorsAndImage(),
                        ),
                        TransparentDivider.h(AppPadding.defaultPadding),

                        if (bookIsInLibrary)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox.fromSize(
                              size: const Size.fromHeight(20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  l10n.searchedBookPageAlreadyInYourLibraryInfo,
                                ),
                              ),
                            ),
                          ),

                        updateStatus ? buildStatusForm() : buildBookInfo(),

                        TransparentDivider.h(AppPadding.defaultPadding / 2),

                        // ADD STATUS BUTTON
                        updateStatus
                            ? buildCancelStatusButton()
                            : buildAddStatusButton(),
                      ],
                    );
                  }),
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
      child: ShowBookPageButton(onPressed: toggleAddStatus),
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
              child: widget.googleBookModel.volumeInfo!.description != null
                  ? buildDescription()
                  : NoDescriptionInfo(),
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
        bookStatus: widget.bookStatus ?? BookStatusCurrentlyReading(),
        isUpdating: widget.updateStatus || bookIsInLibrary,
        oldBookStatus:
            widget.updateStatus || bookIsInLibrary ? widget.bookStatus! : null,
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
        TransparentDivider.w(AppPadding.defaultPadding / 2),
        // IMAGE
        Hero(
          tag: "${widget.googleBookModel.id}_image",
          child: BookImage(
            size: BookImageSize.searchedBook,
            imageUrl:
                widget.googleBookModel.volumeInfo?.imageLinks?.thumbnail ??
                    BookImage.noImageUrl,
          ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // PAGES
          buildGenericBookInfo(
            // !                                 Google Books API Problem
            widget.googleBookModel.volumeInfo?.pageCount?.toString() ?? '368',
            l10n.searchedBookPageGenericInfoPagesTitle,
          ),
          TransparentDivider.w(15.0),
          // RATING STARS or INFO LINK
          // buildRatingStarsOrInfoLink(),
          TransparentDivider.w(15.0),
          // LANGUAGE
          buildGenericBookInfo(
            widget.googleBookModel.volumeInfo?.language
                    ?.toString()
                    .toUpperCase() ??
                '',
            l10n.searchedBookPageGenericInfoLanguageTitle,
          ),
        ],
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
          Text(
            l10n.searchedBookDescriptionTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
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
      return Text(l10n.searchedBookNoDescriptionTitle);
    }
  }

  /// Not considering rating for now.
  buildRatingStarsOrInfoLink() {
    return buildBookInfoLink();
    /*
    num? rating = widget.googleBookModel.volumeInfo?.averageRating;
    if (rating != null) {
      return buildRatingStarsIcons(rating);
    } else {
      return buildBookInfoLink();
    }
    */
  }

  Padding buildBookInfoLink() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextButton.icon(
        icon: Icon(
          Icons.info,
          color: themeController.isDarkTheme
              ? Colors.white
              : LightThemeData.primary,
        ),
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

  buildBookTitle() {
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
