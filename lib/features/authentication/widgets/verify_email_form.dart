import 'dart:async';

import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../../logged_user/logged_user_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  late AppLocalizations l10n;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      //Utils.showSnackBar(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return const UserPage();
    }
    l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitle(),
                  TransparentDivider.h(15.0),
                  buildSubtitle(),
                  TransparentDivider.h(15.0),
                  if (canResendEmail) buildResendEmailButton(),
                  if (canResendEmail)
                    const Divider(
                      height: 20.0,
                      thickness: 1,
                    ),
                  buildBackToLoginButton(),
                  TransparentDivider.h(10.0),
                  Center(
                    child: Lottie.asset(
                      'assets/authentication/verify_email.json',
                      height: 300.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildBackToLoginButton() {
    return TextButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: themeController.isDarkTheme
            ? DarkThemeData.secondary
            : LightThemeData.primary,
        onPrimary: Colors.white,
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      icon: const Icon(
        Icons.arrow_back,
        size: 19.0,
      ),
      label: Text(
        l10n.confirmEmailFormBackToLoginButton,
      ),
      onPressed: () => FirebaseAuth.instance.signOut(),
    );
  }

  Align buildResendEmailButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          primary: themeController.isDarkTheme
              ? DarkThemeData.secondary
              : LightThemeData.primary,
          onPrimary: Colors.white,
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
        icon: const Icon(
          Icons.email,
          //size: 32,
        ),
        label: Text(
          l10n.confirmEmailFormResendButton,
          style: const TextStyle(
            fontSize: 19.0,
          ),
        ),
        onPressed: canResendEmail ? sendVerificationEmail : null,
      ),
    );
  }

  Text buildSubtitle() {
    return Text(
      l10n.confirmEmailFormSubtitle,
      style: TextStyle(
          fontSize: 20.0,
          color: themeController.isDarkTheme
              ? DarkThemeData.onPrimary
              : Colors.black),
    );
  }

  Text buildTitle() {
    return Text(
      l10n.confirmEmailFormTitle,
      style: TextStyles.confirmEmailTitle,
    );
  }
}
