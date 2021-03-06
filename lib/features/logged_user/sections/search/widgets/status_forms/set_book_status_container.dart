// ignore_for_file: must_be_immutable

import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/searched_book_page.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/book_status_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/custom_page_route.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetBookStatusContainer extends StatefulWidget {
  final GoogleBookModel googleBookModel;
  final BookStatus bookStatus;
  final bool isUpdating;
  BookStatus? oldBookStatus;
  SetBookStatusContainer({
    Key? key,
    required this.googleBookModel,
    required this.bookStatus,
    required this.isUpdating,
    this.oldBookStatus,
  }) : super(key: key) {
    oldBookStatus ??= bookStatus;
  }
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
  late AppLocalizations l10n;

  @override
  void initState() {
    super.initState();
    int initialIndex = BookStatusUtil.getIndex(widget.bookStatus);
    tabController = TabController(
      length: BookStatusUtil.bookStatusTypes.length,
      vsync: this,
      initialIndex: initialIndex,
    );
    final currentForm =
        BookStatusUtil.bookStatusFormFromStatus(widget.bookStatus);
    forms[initialIndex] = currentForm;
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
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
        child: Container(
          decoration: BoxDecoration(
            color: themeController.isDarkTheme
                ? DarkThemeData.background
                : Colors.white,
            borderRadius: BorderRadius.circular(
              AppBorders.defaultBorderRadius,
            ),
          ),
          child: Column(
            children: [
              buildTabBars(context),
              const Divider(height: 0),
              if (widget.isUpdating) TransparentDivider.h(10),
              if (widget.isUpdating) buildDeleteStatusButton(),
              TransparentDivider.h(AppPadding.defaultPadding / 2),
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
    );
  }

  buildAddStatusButton() {
    return ElevatedButton(
      onPressed: () {
        final index = tabController!.index;
        final bookStatus = BookStatusUtil.getBookStatusFromForm(forms[index]);
        BookModel bookModel =
            BookModel(bookData: widget.googleBookModel, bookStatus: bookStatus);
        widget.isUpdating
            ? BooksRepository.updateBook(bookModel, widget.oldBookStatus!)
            : BooksRepository.addBook(bookModel);
        _showBookEditedPopup();
      },
      child: Text(
        widget.isUpdating
            ? l10n.editBookStatusAction
            : l10n.addBookStatusAction,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 23.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: themeController.isDarkTheme
            ? DarkThemeData.secondary
            : LightThemeData.primary,
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

  buildDeleteStatusButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          final index = tabController!.index;
          final bookStatus = BookStatusUtil.getBookStatusFromForm(forms[index]);
          BookModel bookModel = BookModel(
            bookData: widget.googleBookModel,
            bookStatus: bookStatus,
          );
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                l10n.deleteBookStatusTitle(
                    widget.googleBookModel.volumeInfo!.title ?? ''),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/logged_user/delete.json',
                    height: 170,
                    width: 220,
                  ),
                  Text(l10n.deleteBookStatusInfo),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    l10n.deleteBookStatusNoAction,
                    style: TextStyle(
                      color: themeController.isDarkTheme
                          ? Colors.white
                          : LightThemeData.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BooksRepository.deleteBookFromBookModel(bookModel);
                    _popPage();
                  },
                  child: Text(
                    l10n.deleteBookStatusYesAction,
                    style: TextStyle(
                      color: themeController.isDarkTheme
                          ? Colors.white
                          : LightThemeData.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        label: Text(
          '',
          style: TextStyle(
            color: Colors.red.withOpacity(0.8),
            fontSize: 19.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          Icons.delete_outline_rounded,
          color: themeController.isDarkTheme
              ? Colors.white
              : LightThemeData.primary,
          size: 30.0,
        ),
      ),
    );
  }

  TabBar buildTabBars(BuildContext context) {
    final texts = BookStatusUtil.getBookStatusTexts(context);
    return TabBar(
      controller: tabController,
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      indicatorColor: LightThemeData.primary,
      tabs: List.from(
        BookStatusUtil.bookStatusTypes
            .map((status) => Tab(text: texts[status])),
      ),
    );
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

  _showBookEditedPopup() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          widget.isUpdating
              ? l10n.bookStatusUpdatedTitle
              : l10n.bookStatusAddedTitle,
        ),
        content: Lottie.asset(
          'assets/logged_user/success.json',
          height: 170,
          width: 220,
          repeat: false,
        ),
        actions: [
          TextButton(
            onPressed: _popPage,
            child: Text(
              'OK',
              style: TextStyle(
                color: themeController.isDarkTheme
                    ? Colors.white
                    : LightThemeData.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _popPage() {
    Navigator.of(context).pushAndRemoveUntil(
      CustomPageRoute(
          child: SearchedBookPage(
        googleBookModel: widget.googleBookModel,
        updateStatus: false,
      )),
      (route) => route.isFirst,
    );
  }
}
