import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/screen/login_form.dart';
import 'package:book_tracker/screen/signup_form.dart';
import 'package:book_tracker/screen/verify_email_screen.dart';
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
              return const Center(
                child:
                    VerifyEmailPage(), // Check if already verified and pushes new route
              );
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

  AppBar _buildAppBar() {
    return AppBar(
        toolbarHeight: 130.0,
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0),
          ),
        ),
        backgroundColor: Palette.primaryLight,
        centerTitle: true,
        title: const Text(
          'Authentication',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 27.0,
            letterSpacing: 1,
          ),
        ),
      );
  }
}
