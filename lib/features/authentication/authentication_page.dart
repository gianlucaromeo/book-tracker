import 'package:book_tracker/config/container.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/authentication/widgets/authentication_forms_container.dart';
import 'package:book_tracker/features/authentication/widgets/verify_email_form.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showLoginForm = true; // False if the Sign-Up form must be shown
  bool isUserLoggedIn = false;

  void toggleFormToShow() {
    setState(() {
      showLoginForm = !showLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
          } else if (snap.hasError) {
            return const Center(
              child: Text('Error'), // TODO add scaffold
            );
          } else if (snap.hasData) {
            // * VERIFY EMAIL PAGE
            return const VerifyEmailPage();
          } else {
            // * LOGIN OR SIGN-UP PAGE
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: AppContainer.defaultHeight,
                title: Container(
                  width: double.infinity,
                  height: AppContainer.defaultHeight,
                  alignment: Alignment.center,
                  decoration: AppContainer.defaultDecorationWithBottomRadius,
                  child: Text(
                    AppLocalizations.of(context)!.authPageTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  TransparentDivider.h(AppPadding.defaultPadding * 2),
                  const AuthenticationFormsContainer(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  bool userEmailVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }
}
