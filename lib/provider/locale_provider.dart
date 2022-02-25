import 'package:book_tracker/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {

  final Locale _defaultLocale = const Locale('en');

  Locale? _currentLocale;

  Locale get currentLocale => _currentLocale?? _defaultLocale;

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