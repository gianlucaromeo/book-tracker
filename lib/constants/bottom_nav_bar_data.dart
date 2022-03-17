import 'package:book_tracker/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBarData {
  static List<BottomNavigationBarItem> getItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      BottomNavigationBarItem(
        backgroundColor: Palette.primaryLight,
        icon: const Icon(Icons.home),
        label: l10n.bottomNavBarItemLabelHome,
      ),
      BottomNavigationBarItem(
        backgroundColor: Palette.primaryLight,
        icon: const Icon(Icons.book),
        label: l10n.bottomNavBarItemLabelMyBooks,
      ),
      BottomNavigationBarItem(
        backgroundColor: Palette.primaryLight,
        icon: const Icon(Icons.search),
        label: l10n.bottomNavBarItemLabelSearch,
      ),
      BottomNavigationBarItem(
        backgroundColor: Palette.primaryLight,
        icon: const Icon(
          Icons.bar_chart,
        ),
        label: l10n.bottomNavBarItemLabelTracker,
      ),
    ];
  }
}
