import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../provider/google_sign_in_provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppBorders.defaultBorderRadius,
        ),
        color: Colors.transparent,
        border: Border.all(
          color: themeController.isDarkTheme
              ? DarkThemeData.secondary
              : LightThemeData.primary,
          //width: 0.5,
        ),
      ),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: themeController.isDarkTheme
              ? DarkThemeData.background
              : LightThemeData.background,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50.0),
          maximumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppBorders.defaultBorderRadius,
            ),
          ),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
          size: LoginSignUpFormSizes.buttonIconSize,
        ),
        label: Text(
          '  ' + AppLocalizations.of(context)!.signInWithGoogleButtonText,
          style: TextStyle(
            color: themeController.isDarkTheme
                ? Colors.white
                : LightThemeData.primary,
            fontSize: 23.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
      ),
    );
  }
}
