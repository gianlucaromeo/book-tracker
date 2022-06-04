import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppDrawerHeader extends StatefulWidget {
  const AppDrawerHeader({Key? key}) : super(key: key);

  @override
  State<AppDrawerHeader> createState() => _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = themeController.isDarkTheme;
    final _divider = TransparentDivider.h(5.0);
    return DrawerHeader(
      child: Center(
        child: Column(
          children: [
            // AVATAR ICON
            Icon(
              Icons.person_outline_rounded,
              color: isDarkTheme ? Colors.white : Colors.black,
              size: 35,
            ),
            _divider,
            // EMAIL
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 15.0),
            ),
            _divider,
            // DELETE ACCOUNT
            TextButton.icon(
              icon: const Icon(
                Icons.person_off_outlined,
                color: Colors.red,
              ),
              onPressed: _showDeleteAccountDialog,
              label: Text(
                'Delete account',
                style: TextStyle(
                  color: isDarkTheme
                      ? DarkThemeData.onPrimary
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDeleteAccountDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Are you sure you want to delete your account?\nYour data will be delete permanently.',
        ),
        content: Lottie.asset(
          'assets/logged_user/delete.json',
          height: 140,
          width: 190,
          repeat: false,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'NO',
              style: TextStyle(
                color: themeController.isDarkTheme
                    ? Colors.white
                    : LightThemeData.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser!.delete();
              Navigator.of(context).pop();
            },
            child: Text(
              'YES, DELETE',
              style: TextStyle(
                color: themeController.isDarkTheme
                    ? Colors.white
                    : LightThemeData.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
