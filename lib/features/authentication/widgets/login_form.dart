import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/main.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'google_sign_in_button.dart';

class LoginForm extends StatefulWidget {
  //final VoidCallback? onSignUpClicked;

  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late AppLocalizations _l10n;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loginError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TransparentDivider.h(AppPadding.defaultPadding),
          // EMAIL FIELD
          buildEmailField(),
          TransparentDivider.h(AppPadding.defaultPadding),
          // PASSWORD FIELD
          buildPasswordField(),
          TransparentDivider.h(AppPadding.defaultPadding),
          // CHECK IF LOGIN ERROR
          if (_loginError)
            const Text(
              'Please check your credentials and try again.',
              style: TextStyle(color: Colors.red, fontSize: 18.0),
            ),
          if (_loginError) TransparentDivider.h(AppPadding.defaultPadding),
          // SIGN-IN BUTTON
          buildDoLoginButton(),
          const Divider(thickness: 1, height: 30.0),
          // GOOGLE SIGN-IN BUTTON
          const GoogleSignInButton(),
          TransparentDivider.h(AppPadding.defaultPadding),
          // FORGOT PASSWORD LINK
          buildForgotPasswordLink(context),
        ],
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
            recognizer: TapGestureRecognizer()
              ..onTap = null, //!widget.onSignUpClicked,
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
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.black.withOpacity(0.5),
          fontSize: 20.0,
        ),
      ),
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.forgotPasswordPageRouteName),
    );
  }

  buildDoLoginButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.defaultPadding / 2),
          child: Text(
            _l10n.loginFormSignInButtonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            ),
          ),
        ),
        onPressed: _doLogin,
      ),
    );
  }

  TextField buildPasswordField() {
    return TextField(
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.loginFormPasswordFieldLabelText,
        focusedBorder: LoginSignUpFormSizes.border,
        enabledBorder: LoginSignUpFormSizes.border,
        border: LoginSignUpFormSizes.border,
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
        focusedBorder: LoginSignUpFormSizes.border,
        enabledBorder: LoginSignUpFormSizes.border,
        border: LoginSignUpFormSizes.border,
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

  Future _doLogin() async {
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
    } on FirebaseAuthException {
      setState(() {
        _loginError = true;
      });
      //Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
