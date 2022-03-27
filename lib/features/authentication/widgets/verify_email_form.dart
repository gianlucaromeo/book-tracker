import 'dart:async';

import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../logged_user/logged_user_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  AppLocalizations? l10n;

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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
          child: Column(
            children: [
              buildTitle(),
              TransparentDivider.h(15.0),
              buildSubtitle(),
              TransparentDivider.h(15.0),
              buildResendEmailButton(),
              const Divider(
                height: 20.0,
                thickness: 1,
              ),
              buildBackToLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton buildBackToLoginButton() {
    return TextButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(LoginSignUpFormSizes.buttonHeight),
        //onPrimary: Colors.white,
        // primary: Palette.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
        ),
      ),
      icon: const Icon(
        Icons.arrow_back,
        size: LoginSignUpFormSizes.buttonIconSize,
      ),
      label: Text(
        l10n!.confirmEmailFormBackToLoginButton,
        style: TextStyles.confirmEmailBackToLoginButton,
      ),
      onPressed: () => FirebaseAuth.instance.signOut(),
    );
  }

  ElevatedButton buildResendEmailButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(70.0),
        //onPrimary: Colors.white,
        //primary: Palette.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const Icon(
        Icons.email,
        size: 32,
      ),
      label: Text(
        l10n!.confirmEmailFormResendButton,
        style: TextStyles.confirmEmailResendEmail,
      ),
      onPressed: canResendEmail ? sendVerificationEmail : null,
    );
  }

  Text buildSubtitle() {
    return Text(
      l10n!.confirmEmailFormSubtitle,
      style: TextStyles.confirmEmailSubtitle,
    );
  }

  Align buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        l10n!.confirmEmailFormTitle,
        style: TextStyles.confirmEmailTitle,
      ),
    );
  }
}
