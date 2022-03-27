import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../provider/google_sign_in_provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
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
    );
  }
}
