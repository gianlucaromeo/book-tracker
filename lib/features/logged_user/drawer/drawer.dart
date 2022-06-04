import 'package:book_tracker/features/logged_user/drawer/change_language_tile.dart';
import 'package:book_tracker/features/logged_user/drawer/dark_theme_tile.dart';
import 'package:book_tracker/features/logged_user/drawer/header_tile.dart';
import 'package:book_tracker/features/logged_user/drawer/logout_tile.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeController.isDarkTheme
          ? DarkThemeData.primary
          : LightThemeData.background,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: const [
          AppDrawerHeader(),
          LogoutTile(),
          DarkThemeSwitch(),
          ChangeLanguageTile(),
        ],
      ),
    );
  }
}
