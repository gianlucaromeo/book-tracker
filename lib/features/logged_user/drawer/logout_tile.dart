import 'package:book_tracker/provider/google_sign_in_provider.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoutTile extends StatefulWidget {
  const LogoutTile({Key? key}) : super(key: key);

  @override
  State<LogoutTile> createState() => _LogoutTileState();
}

class _LogoutTileState extends State<LogoutTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              child: Text(
                AppLocalizations.of(context)!.drawerLogoutTitle,
                style: TextStyle(
                  color: themeController.isDarkTheme
                      ? DarkThemeData.onPrimary
                      : Colors.black.withOpacity(0.5),
                  fontSize: 19.0,
                ),
              ),
              onTap: () {
                final String providerId = FirebaseAuth
                    .instance.currentUser!.providerData[0].providerId;
                if (providerId == 'google.com') {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                } else {
                  FirebaseAuth.instance.signOut();
                }
              })),
    );
  }
}
