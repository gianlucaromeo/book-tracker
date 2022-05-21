import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
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
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          onPrimary: themeController.isDarkTheme ? Colors.white : Colors.black,
          minimumSize: const Size.fromHeight(LoginSignUpFormSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
          ),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
          size: LoginSignUpFormSizes.buttonIconSize,
        ),
        label: Text(
          '  ' + AppLocalizations.of(context)!.signInWithGoogleButtonText,
          style: TextStyles.authFormButton,
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
