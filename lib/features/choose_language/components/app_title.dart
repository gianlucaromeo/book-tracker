import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Left-aligned title of the App with big font size.
class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context)!.chooseLanguageTitle,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              color: themeController.isDarkTheme ? Colors.white : Colors.black,
            ),
      ),
    );
  }
}
