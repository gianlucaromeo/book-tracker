import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/book_of_the_day_section.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/curiosity_tile.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/discover_books_section.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSectionHome extends StatelessWidget {
  UserSectionHome({Key? key}) : super(key: key);
  late AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookOfTheDaySection(),
          TransparentDivider.h(AppPadding.defaultPadding),
          CuriosityTile(
            title: l10n.curiosity_TheBible_title,
            description: l10n.curiosity_TheBible_description,
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          CuriosityTile(
            title: l10n.curiosity_RemembranceOfThingsPast_title,
            description: l10n.curiosity_RemembranceOfThingsPast_description,
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          const DiscoverBooksSection(),
          TransparentDivider.h(AppPadding.defaultPadding),
          CuriosityTile(
            title: l10n.curiosity_BooksPublished_title,
            description: l10n.curiosity_BooksPublished_description,
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          CuriosityTile(
            title: l10n.curiosity_TheCodexLeicester_title,
            description: l10n.curiosity_TheCodexLeicester_description,
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          CuriosityTile(
            title: l10n.curiosity_DidYouKnowThat_title,
            description: l10n.curiosity_DidYouKnowThat_description,
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
        ],
      ),
    );
  }
}
