import 'package:book_tracker/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Title of the App with big font size as a widget.
class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context)!.chooseLanguageTitle,
        style: TextStyles.chooseLanguageAppTitle,
      ),
    );
  }
}
