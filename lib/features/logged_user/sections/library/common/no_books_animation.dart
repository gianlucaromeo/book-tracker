import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoBooksAnimation extends StatelessWidget {
  NoBooksAnimation({Key? key}) : super(key: key);
  late AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppPadding.defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: Lottie.asset(
              'assets/logged_user/no_books.json',
              height: 300,
            ),
          ),
          TransparentDivider.h(AppPadding.defaultPadding / 2),
          Text(
            l10n.booksSectionEmpty,
            style:
                Theme.of(context).textTheme.overline!.copyWith(fontSize: 19.0),
          ),
        ],
      ),
    );
  }
}
