import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/repository/ibs_to_books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found_tile.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookOfTheDaySection extends StatelessWidget {
  BookOfTheDaySection({Key? key}) : super(key: key);
  late AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppPadding.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(color: Theme.of(context).colorScheme.shadow),
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: IBSToBooksRepository.bookOfTheDay(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.bookOfTheDaySectionTitle,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color),
                  ),
                  TransparentDivider.h(AppPadding.defaultPadding),
                  BookFoundTile(
                    book: GoogleBookModel.fromJson(
                      snap.data!.docs.first.data() as Json,
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
