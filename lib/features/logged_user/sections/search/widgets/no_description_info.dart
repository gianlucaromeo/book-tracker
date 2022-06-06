import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoDescriptionInfo extends StatelessWidget {
  NoDescriptionInfo({Key? key}) : super(key: key);
  late AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/logged_user/no_description_error.json',
          height: 150,
          width: 220,
        ),
        TransparentDivider.h(AppPadding.defaultPadding / 2),
        Text(
          l10n.searchedBookNoDescriptionTitle,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 23.0,
          ),
        ),
        TransparentDivider.h(AppPadding.defaultPadding),
        Text(
          l10n.searchedBookNoDescriptionInfo,
          maxLines: 2,
        ),
      ],
    );
  }
}
