import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../provider/google_sign_in_provider.dart';
import 'google_sign_in_button.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSignUpClicked;

  const LoginForm({Key? key, required this.onSignUpClicked}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  late final AppLocalizations _l10n;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int _milliseconds = 100;
    _l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // - Title
            FadeInAnimation(
              child: _buildTitle(),
              milliseconds: _milliseconds,
            ),
            TransparentDivider.h(20.0),

            // -- Email Field
            FadeInAnimation(
              child: _buildEmailField(),
              milliseconds: _milliseconds,
            ),
            TransparentDivider.h10(),

            // -- Password
            FadeInAnimation(
              child: _buildPasswordField(),
              milliseconds: _milliseconds,
            ),
            TransparentDivider.h(20.0),

            // Sign-in Button
            FadeInAnimation(
              child: _buildSignInButton(),
              milliseconds: _milliseconds,
            ),
            const Divider(thickness: 1, height: 30.0),

            // -- Sign-in with Google
            FadeInAnimation(
              child: const GoogleSignInButton(),
              milliseconds: _milliseconds,
            ),
            TransparentDivider.h(20.0),

            // -- Forgot Password
            FadeInAnimation(
              child: _buildForgotPassword(context),
              milliseconds: _milliseconds,
            ),
            TransparentDivider.h(20.0),

            // -- No Account ? Sign Up
            FadeInAnimation(
              child: _buildGoToSignUpButton(context),
              milliseconds: _milliseconds,
            ),
          ],
        ),
      ),
    );
  }

  RichText _buildGoToSignUpButton(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20.0,
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
        text: _l10n.loginFormNoAccount,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onSignUpClicked,
            text: _l10n.loginFormSignUpText,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }


  GestureDetector _buildForgotPassword(BuildContext context) {
    return GestureDetector(
      child: Text(
        _l10n.loginFormForgotPasswordText,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20.0,
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(Routes.forgotPasswordPageRouteName),
    );
  }

  ElevatedButton _buildSignInButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const Icon(
        Icons.lock_open,
        size: 32.0,
      ),
      label: Text(
        _l10n.loginFormSignInButtonText,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      onPressed: _signIn,
    );
  }

  TextField _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      cursorColor: Colors.green,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.loginFormPasswordFieldLabelText,
      ),
      obscureText: true,
    );
  }

  TextField _buildEmailField() {
    return TextField(
      controller: _emailController,
      cursorColor: Colors.red,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.loginFormEmailFieldLabelText,
      ),
    );
  }

  Align _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _l10n.loginFormTitle,
        style: const TextStyle(
          fontSize: 32.0,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future _signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}