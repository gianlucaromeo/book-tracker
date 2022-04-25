import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/book_status_util.dart';
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: BookStatusUtil.getIndex(widget.bookStatus),
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
