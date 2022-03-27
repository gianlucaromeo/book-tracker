import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/main.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    _l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ! ONLY FOR DEBUG
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.chooseLanguagePageRouteName, (route) => false),
              child: const Text('Show Tutorial'),
            ),
            // TITLE
            buildTitle(),
            TransparentDivider.h(20.0),
            // EMAIL FIELD
            buildEmailField(),
            TransparentDivider.h10(),
            // PASSWORD FIELD
            buildPasswordField(),
            TransparentDivider.h(20.0),
            // SIGN-IN BUTTON
            buildSignInButton(),
            const Divider(thickness: 1, height: 30.0),
            // GOOGLE SIGN-IN BUTTON
            const GoogleSignInButton(),
            TransparentDivider.h(20.0),
            // FORGOT PASSWORD LINK
            buildForgotPasswordLink(context),
            TransparentDivider.h(20.0),
            // NO ACCOUNT ? SIGN-UP LINK
            buildGoToSignUpLink(context),
          ],
        ),
      ),
    );
  }

  RichText buildGoToSignUpLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyles.switchAuthFormLink,
        text: _l10n.loginFormNoAccount,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onSignUpClicked,
            text: _l10n.loginFormSignUpText,
            // No need for this TextStyle to be inside the TextStyles class
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildForgotPasswordLink(BuildContext context) {
    return GestureDetector(
      child: Text(
        _l10n.loginFormForgotPasswordText,
        style: TextStyles.loginFormForgotPasswordLink,
      ),
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.forgotPasswordPageRouteName),
    );
  }

  ElevatedButton buildSignInButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(LoginSignUpFormSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
        ),
      ),
      icon: const Icon(
        Icons.lock_open,
        size: LoginSignUpFormSizes.buttonIconSize,
      ),
      label: Text(
        _l10n.loginFormSignInButtonText,
        style: TextStyles.authFormButton,
      ),
      onPressed: _doSignIn,
    );
  }

  TextField buildPasswordField() {
    return TextField(
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.loginFormPasswordFieldLabelText,
      ),
      obscureText: true,
    );
  }

  TextField buildEmailField() {
    return TextField(
      controller: _emailController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.loginFormEmailFieldLabelText,
      ),
    );
  }

  Align buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _l10n.loginFormTitle,
        style: TextStyles.authPageFormTitle,
      ),
    );
  }

  Future _doSignIn() async {
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
