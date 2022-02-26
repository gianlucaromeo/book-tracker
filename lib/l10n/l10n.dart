import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final supportedLocales = [
    const Locale('en'),
    const Locale('it'),
  ];

  static Locale getLocaleFromLanguageName(
      String languageName, BuildContext context) {
    if (languageName == AppLocalizations.of(context)!.italian) {
      return const Locale('it');
    }
    return const Locale('en');
  }

  static List<String> getSupportedLanguagesNames(BuildContext context) {
    return [
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.italian,
    ];
  }
}
