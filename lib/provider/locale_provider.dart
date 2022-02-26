import 'package:book_tracker/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleProvider extends ChangeNotifier {

  final Locale _defaultLocale = const Locale('en');

  Locale? _currentLocale;

  Locale get currentLocale => _currentLocale?? _defaultLocale;

  String getCurrentLanguageName(BuildContext context) {
    if (currentLocale == const Locale('it')) {
      return AppLocalizations.of(context)!.italian;
    }
    // Default
    return AppLocalizations.of(context)!.english;
  }

  void setLocale(Locale locale) {
    if (locale != _currentLocale) {
      if (L10n.supportedLocales.contains(locale)) {
        _currentLocale = locale;
        notifyListeners();
      }
    }
  }

  void clearLocale() {
    _currentLocale = null;
    notifyListeners();
  }

}