import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/main.dart';
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
  late final AppLocalizations l10n;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        title: Text(
          l10n.authPageTitle,
          style: TextStyles.authPageAppBarTitle,
        ),
        iconTheme: IconThemeData(
          color: themeController.currentThemeMode == ThemeMode.light
              ? Colors.black
              : Colors.white,
          size: 50.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(LoginSignUpFormSizes.buttonBorderRadius),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TITLE
              TransparentDivider.h10(),
              buildTitle(),
              // SUBTITLE
              TransparentDivider.h(10.0),
              buildSubtitle(),
              // EMAIL FIELD
              TransparentDivider.h(20.0),
              buildEmailField(),
              // RESET PASSWORD BUTTON
              TransparentDivider.h(20.0),
              buildResetPasswordButton(),
              // LOTTIE ANIMATION
              TransparentDivider.h(20.0),
              Expanded(
                child:
                    Lottie.asset('assets/authentication/forgot_password.json'),
              ),
            ],
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
        style: TextStyles.forgotPasswordSubtitle,
      ),
    );
  }

  buildEmailField() {
    return TextFormField(
      controller: emailController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: l10n.forgotPasswordFormEmailFieldText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? l10n.forgotPasswordFormEmailErrorText
          : null,
    );
  }

  buildResetPasswordButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(LoginSignUpFormSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
        ),
      ),
      icon: const Icon(
        Icons.email_outlined,
        size: LoginSignUpFormSizes.buttonIconSize,
      ),
      label: Text(
        l10n.forgotPasswordFormResetButton,
        style: TextStyles.authFormButton,
      ),
      onPressed: _doResetPassword,
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
      print('Password Reset Email Sent');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Navigator.of(context).pop();
    }
  }
}
