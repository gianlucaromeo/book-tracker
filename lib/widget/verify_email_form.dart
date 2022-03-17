import 'dart:async';

import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screen/user_pages/user_screen.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({Key? key}) : super(key: key);

  @override
  _VerifyEmailFormState createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

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
    timer?.cancel;
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (isEmailVerified) {
        timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified) {
      return const UserPage();
    }
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            _buildTitle(),
            TransparentDivider.h(15.0),
            _buildSubtitle(),
            TransparentDivider.h(15.0),
            _buildResendEmailButton(),
            const Divider(height: 20.0, thickness: 1,),
            _buildBackToLoginButton(),
          ],
        ),
      ),
    );
  }

  TextButton _buildBackToLoginButton() {
    return TextButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(70.0),
        onPrimary: Colors.white,
        primary: Palette.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0,),
      label: const Text(
        'Back to Login',
        style: TextStyle(fontSize: 24.0),
      ),
      onPressed: () => FirebaseAuth.instance.signOut(),
    );
  }

  ElevatedButton _buildResendEmailButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(70.0),
        onPrimary: Colors.white,
        primary: Palette.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const Icon(
        Icons.email,
        size: 32,
      ),
      label: const Text(
        'Resend email',
        style: TextStyle(fontSize: 24.0),
      ),
      onPressed: canResendEmail ? sendVerificationEmail : null,
    );
  }

  Text _buildSubtitle() {
    return const Text(
      'A verification email has been sent to your email.',
      style: TextStyle(fontSize: 20.0),
    );
  }

  Align _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Verification',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


}
