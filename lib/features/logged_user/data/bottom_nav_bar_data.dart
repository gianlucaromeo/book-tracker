import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBarData {
  static List<BottomNavigationBarItem> getItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    //const backgroundColor = Colors.white;
    Color iconColor = themeController.currentThemeMode == ThemeMode.light
        ? Colors.black.withOpacity(0.7)
        : Colors.white.withOpacity(0.7);
    return [
      BottomNavigationBarItem(
        //backgroundColor: backgroundColor,
        icon: Icon(
          Icons.home,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelHome,
      ),
      BottomNavigationBarItem(
        // backgroundColor: backgroundColor,
        icon: Icon(
          Icons.book,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelMyBooks,
      ),
      BottomNavigationBarItem(
        //backgroundColor: backgroundColor,
        icon: Icon(
          Icons.search,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelSearch,
      ),
      BottomNavigationBarItem(
        //backgroundColor: backgroundColor,
        icon: Icon(
          Icons.bar_chart,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelTracker,
      ),
    ];
  }
}
