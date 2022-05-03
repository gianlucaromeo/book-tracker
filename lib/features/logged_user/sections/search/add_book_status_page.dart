import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/book_status_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
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

class _AddBookStatusPageState extends State<AddBookStatusPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<Widget> forms = List.from(
    BookStatusUtil.bookStatusTypes
        .map((status) => BookStatusUtil.bookStatusForms[status]!),
  );

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: BookStatusUtil.bookStatusTypes.length,
      vsync: this,
      initialIndex: BookStatusUtil.getIndex(widget.bookStatus),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeController.isDarkTheme
            ? DarkThemeData.surface
            : LightThemeData.primary,
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
                    color: themeController.isDarkTheme
                        ? DarkThemeData.background
                        : Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppBorders.defaultBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppPadding.defaultPadding / 2),
                  child: Expanded(
                    child: Column(
                      children: [
                        // IMAGE, TITLE, AUTHORS
                        buildImageTitleAuthors(context),
                        const Divider(height: AppPadding.defaultPadding * 2),
                        buildTabBars(context),
                        TransparentDivider.h(10.0),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            physics: const BouncingScrollPhysics(),
                            children: forms,
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
    );
  }

  buildAddStatusButton() {
    return ElevatedButton(
      onPressed: () {
        final index = tabController!.index;
        final bookStatus = BookStatusUtil.getBookStatusFromForm(forms[index]);
        BookModel bookModel =
            BookModel(bookData: widget.googleBookModel, bookStatus: bookStatus);
        BooksRepository.addBook(bookModel);
      },
      child: const Text(
        'Add Book',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: themeController.isDarkTheme
            ? DarkThemeData.onPrimary
            : Colors.green.withOpacity(0.8),
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
    final texts = BookStatusUtil.getBookStatusTexts(context);
    const icons = BookStatusUtil.bookStatusIcons;
    return TabBar(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabs: List.from(
          BookStatusUtil.bookStatusTypes.map(
            (status) => Tab(
              icon: Icon(
                icons[status],
                size: 32.0,
              ),
              text: texts[status],
            ),
          ),
        ));
  }

  Row buildImageTitleAuthors(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BookImage(
          size: BookImageSize.setBookStatus,
          imageUrl: widget.googleBookModel.volumeInfo?.imageLinks!.thumbnail,
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
