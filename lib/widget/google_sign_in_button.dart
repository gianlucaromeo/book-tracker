import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/google_sign_in_provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.9),
        minimumSize: const Size.fromHeight(60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
      label: Text(
        AppLocalizations.of(context)!.signInWithGoogleButtonText,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
      onPressed: () {
        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogin();
      },
    );
  }
}
