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

class SetBookStatusContainer extends StatefulWidget {
  final GoogleBookModel googleBookModel;
  final BookStatus bookStatus;
  const SetBookStatusContainer(
      {Key? key, required this.googleBookModel, required this.bookStatus})
      : super(key: key);
  @override
  State<SetBookStatusContainer> createState() => _SetBookStatusContainerState();
}

class _SetBookStatusContainerState extends State<SetBookStatusContainer>
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.defaultPadding,
          AppPadding.defaultPadding / 2,
          AppPadding.defaultPadding,
          AppPadding.defaultPadding,
        ),
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: themeController.isDarkTheme
                  ? DarkThemeData.background
                  : Colors.white,
              borderRadius: BorderRadius.circular(
                AppBorders.defaultBorderRadius,
              ),
            ),
            child: Expanded(
              child: Column(
                children: [
                  buildTabBars(context),
                  const Divider(height: 0),
                  TransparentDivider.h(10),
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
        minimumSize: const Size(double.infinity, 50.0),
        maximumSize: const Size(double.infinity, 50.0),
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
        indicatorColor: LightThemeData.primary,
        tabs: List.from(
          BookStatusUtil.bookStatusTypes.map(
            (status) => Tab(
              /*
              icon: Icon(
                icons[status],
                size: 32.0,
              ),*/
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
