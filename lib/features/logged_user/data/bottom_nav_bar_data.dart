import 'package:flutter/material.dart';

class BottomNavBarData {
  static const _iconsData = [
    Icons.home_outlined, // HOME
    Icons.book_outlined, // LIBRARY
    Icons.search_outlined, // SEARCH
  ];

  static List<BottomNavigationBarItem> get items => List.generate(
        _iconsData.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(_iconsData[index]),
          label: '', // ! Required
        ),
      );
}

/* IF LABEL TEXT REQUIRED: */
  // final l10n = AppLocalizations.of(context)!;
  // l10n.bottomNavBarItemLabelHome
  // l10n.bottomNavBarItemLabelMyBooks
  // l10n.bottomNavBarItemLabelSearch
  // l10n.bottomNavBarItemLabelTracker
