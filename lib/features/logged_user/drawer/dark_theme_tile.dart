import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DarkThemeSwitch extends StatefulWidget {
  const DarkThemeSwitch({Key? key}) : super(key: key);

  @override
  State<DarkThemeSwitch> createState() => _DarkThemeSwitchState();
}

class _DarkThemeSwitchState extends State<DarkThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.drawerDarkThemeTitle,
            style: const TextStyle(
              fontSize: 19.0,
            ),
          ),
          Switch(
            value: themeController.isDarkTheme,
            onChanged: (_) => themeController.toggleTheme(),
            activeColor: LightThemeData.primary,
          ),
        ],
      ),
    );
  }
}
