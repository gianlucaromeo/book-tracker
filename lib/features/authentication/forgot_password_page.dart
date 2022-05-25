import 'package:book_tracker/config/container.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/main.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late AppLocalizations l10n;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    final _divider = TransparentDivider.h(15.0);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: AppContainer.defaultHeight,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.defaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TITLE
                buildTitle(),
                // SUBTITLE
                _divider,
                buildSubtitle(),
                // EMAIL FIELD
                _divider,
                buildEmailField(),
                _divider,
                // RESET PASSWORD BUTTON
                buildResetPasswordButton(),
                // LOTTIE ANIMATION
                TransparentDivider.h(AppPadding.defaultPadding * 2),
                Lottie.asset(
                  'assets/authentication/forgot_password.json',
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        l10n.forgotPasswordFormTitle,
        style: TextStyles.forgotPasswordTitle,
      ),
    );
  }

  buildSubtitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        l10n.forgotPasswordFormSubtitle,
        style: TextStyle(
            fontSize: 18.0,
            color: themeController.isDarkTheme
                ? DarkThemeData.onPrimary
                : Colors.black),
      ),
    );
  }

  buildEmailField() {
    return TextFormField(
      controller: emailController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: l10n.forgotPasswordFormEmailFieldText,
        focusedBorder: LoginSignUpFormSizes.border,
        enabledBorder: LoginSignUpFormSizes.border,
        border: LoginSignUpFormSizes.border,
        floatingLabelStyle: LoginSignUpFormSizes.floatingLabelStyle,
      ),
      cursorColor: LoginSignUpFormSizes.cursorColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? l10n.forgotPasswordFormEmailErrorText
          : null,
    );
  }

  buildResetPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
          ),
          primary: themeController.isDarkTheme
              ? DarkThemeData.secondary
              : LightThemeData.primary,
          onPrimary: Colors.white,
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
        icon: const Icon(
          Icons.email_outlined,
          size: LoginSignUpFormSizes.buttonIconSize,
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.defaultPadding / 2),
          child: Text(
            l10n.forgotPasswordFormResetButton,
            style: TextStyles.authFormButton,
          ),
        ),
        onPressed: _doResetPassword,
      ),
    );
  }

  Future _doResetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      //print('Password Reset Email Sent');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException {
      Navigator.of(context).pop();
    }
  }
}
