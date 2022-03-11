import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:book_tracker/util/app_bar_util.dart';
import 'package:book_tracker/widget/login_form.dart';
import 'package:book_tracker/widget/signup_form.dart';
import 'package:book_tracker/widget/verify_email_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  AppBar _buildAppBar() {
    return AppBarUtil.buildAppBar(
      toolbarHeight: 130.0,
      elevation: 0.0,
      centerTitle: true,
      text: AppLocalizations.of(context)!.authPageTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasError) {
              return const Center(
                child: Text('Error'), // TODO
              );
            } else if (snap.hasData) {
              return const VerifyEmailForm();
            } else {
              return isLogin
                  ? LoginForm(onSignUpClicked: toggle)
                  : SignUpForm(onClickedSignIn: toggle);
            }
          },
        ),
      ),
    );
  }
}
