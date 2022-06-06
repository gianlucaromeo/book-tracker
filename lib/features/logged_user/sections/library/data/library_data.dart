import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibraryData {
  static getLibrarySections(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return [
      l10n.allBooksTitle,
      l10n.readBooksTitle,
      l10n.currentlyReadingBooksTitle,
      l10n.toReadBooksTitle,
    ];
  }
}
