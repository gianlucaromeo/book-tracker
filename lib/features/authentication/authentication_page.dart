import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:book_tracker/theme/app_bar_theme.dart';
import 'package:book_tracker/features/authentication/widgets/login_form.dart';
import 'package:book_tracker/features/authentication/widgets/signup_form.dart';
import 'package:book_tracker/features/authentication/widgets/verify_email_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            return const VerifyEmailForm(); // TODO add scaffold
          } else {
            return Scaffold(
              appBar: AppBar(
                  title: Text(
                AppLocalizations.of(context)!.authPageTitle,
              )),
              body: showLoginForm
                  ? LoginForm(onSignUpClicked: toggleFormToShow)
                  : SignUpForm(onClickedSignIn: toggleFormToShow),
            );
          }
        },
      ),
    );
  }

  bool userEmailVerified() {
    print('CHECK EMAIL: ' +
        (FirebaseAuth.instance.currentUser!.emailVerified ? 'OK' : "NO"));
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }
}
