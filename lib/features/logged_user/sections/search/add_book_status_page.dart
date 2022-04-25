import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/status_to_read_form.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class AddBookStatusPage extends StatefulWidget {
  final GoogleBookModel googleBookModel;
  final BookStatus bookStatus;
  const AddBookStatusPage(
      {Key? key, required this.googleBookModel, required this.bookStatus})
      : super(key: key);
  @override
  State<AddBookStatusPage> createState() => _AddBookStatusPageState();
}

class _AddBookStatusPageState extends State<AddBookStatusPage> {
  final buttonsTexts = ['Read', 'Currently reading', 'To read'];
  bool? like;

  int getInitialIndex() {
    if (widget.bookStatus is BookStatusRead) {
      return 0;
    } else if (widget.bookStatus is BookStatusCurrentlyReading) {
      return 1;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: getInitialIndex(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GO BACK ICON
                buildGoBackIcon(),
                TransparentDivider.h(AppPadding.defaultPadding),
                // MAIN CONTAINER
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppBorders.defaultBorderRadius,
                      ),
                    ),
                    padding:
                        const EdgeInsets.all(AppPadding.defaultPadding / 2),
                    child: Expanded(
                      child: Column(
                        children: [
                          // IMAGE, TITLE, AUTHORS
                          buildImageTitleAuthors(context),
                          const Divider(),
                          buildTabBars(context),
                          TransparentDivider.h(10.0),
                          const Expanded(
                            child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                BookStatusToReadForm(),
                                BookStatusToReadForm(),
                                BookStatusToReadForm(),
                              ],
                            ),
                          ),
                          TransparentDivider.h(10.0),
                          buildAddStatusButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAddStatusButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text(
        'Add Book',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.green.withOpacity(0.7),
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 60.0),
        maximumSize: const Size(double.infinity, 60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppBorders.defaultBorderRadius,
          ),
        ),
      ),
    );
  }

  TabBar buildTabBars(BuildContext context) {
    return TabBar(
      physics: const BouncingScrollPhysics(),
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      indicatorColor: Colors.transparent,
      tabs: const [
        Tab(
          icon: Icon(Icons.done_outline_outlined),
          text: 'Read',
        ),
        Tab(
          icon: Icon(Icons.timelapse_outlined),
          text: 'Currently reading',
        ),
        Tab(
          icon: Icon(Icons.calendar_today_outlined),
          text: 'To read',
        ),
      ],
    );
  }

  Row buildImageTitleAuthors(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BookImage(
          size: BookImageSize.setBookStatus,
          imageUrl: widget.googleBookModel.volumeInfo?.imageUrl,
        ),
        TransparentDivider.w(AppPadding.defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              Text(
                widget.googleBookModel.volumeInfo?.title ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // AUTHORS
              Text(
                widget.googleBookModel.volumeInfo?.authorsAsString ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ],
    );
  }

  IconButton buildGoBackIcon() {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(
        Icons.arrow_back_outlined,
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}


/* 
Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppBorders.defaultBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppPadding.defaultPadding / 2),
                  child: Column(
                    children: [
                      // BOOK IMAGE - TITLE - LIKE/DISLIKE
                      Row(
                        children: [
                          // IMAGE
                          BookImage(
                            size: BookImageSize.setBookStatus,
                            imageUrl:
                                widget.googleBookModel.volumeInfo?.imageUrl,
                          ),
                          TransparentDivider.w(AppPadding.defaultPadding),
                          // TITLE AND ICONS
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.googleBookModel.volumeInfo!.title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TransparentDivider.h(AppPadding.defaultPadding),
                                // THUMB UP / DOWN --- ICON
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.thumb_up_alt_outlined,
                                        color: like == null
                                            ? Colors.black
                                            : like!
                                                ? Colors.green.withOpacity(0.8)
                                                : Colors.black.withOpacity(0.6),
                                        size: 50.0,
                                      ),
                                      onPressed: () => setState(() {
                                        if (like == null) {
                                          like = true;
                                        } else {
                                          if (like == false)
                                            like = true;
                                          else
                                            like = null;
                                        }
                                      }),
                                    ),
                                    TransparentDivider.w(25.0),
                                    IconButton(
                                      icon: Icon(
                                        Icons.thumb_down_alt_outlined,
                                        color: like == null
                                            ? Colors.black
                                            : like!
                                                ? Colors.black.withOpacity(0.6)
                                                : Colors.red.withOpacity(0.8),
                                        size: 50.0,
                                      ),
                                      onPressed: () => setState(() {
                                        if (like == null) {
                                          like = false;
                                        } else {
                                          if (like == true)
                                            like = false;
                                          else
                                            like = null;
                                        }
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // ACTION BUTTONS
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.5, top: 12.5, right: 12.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++)
                              Expanded(
                                flex: i == 1 ? 1 : 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.5),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      backgroundColor: i == 2
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey.withOpacity(0.5),
                                      minimumSize: const Size(0, 50.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppBorders.defaultBorderRadius),
                                      ),
                                    ),
                                    child: Text(
                                      buttonsTexts[i],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      TransparentDivider.h(AppPadding.defaultPadding),
                      Divider(
                        height: 1.0,
                      ),
                      TransparentDivider.h(AppPadding.defaultPadding),
                      TransparentDivider.h(AppPadding.defaultPadding),
                      Divider(
                        height: 1.0,
                      ),
                      TransparentDivider.h(AppPadding.defaultPadding * 2),
                      // SELECTED FORM
                      BookStatusToReadForm(),
                      TransparentDivider.h(20.0),
                      Spacer(),
                      // ADD BOOK BUTTON
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.withOpacity(0.7),
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(double.infinity, 100.0),
                          maximumSize: const Size(double.infinity, 100.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppBorders.defaultBorderRadius,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
*/