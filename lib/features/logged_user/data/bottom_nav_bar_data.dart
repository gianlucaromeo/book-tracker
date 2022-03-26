import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBarData {

  static List<BottomNavigationBarItem> getItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const backgroundColor = Colors.white;
    const iconColor = Colors.grey;
    return [
      BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: const Icon(
          Icons.home,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelHome,
      ),
      BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: const Icon(
          Icons.book,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelMyBooks,
      ),
      BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: const Icon(
          Icons.search,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelSearch,
      ),
      BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: const Icon(
          Icons.bar_chart,
          color: iconColor,
        ),
        label: l10n.bottomNavBarItemLabelTracker,
      ),
    ];
  }
}
