import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {

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
      return const HomePage();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'A verification email has been sent to your email.',
            style: TextStyle(fontSize:  20.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50.0),
            ),
            icon: const Icon(
              Icons.email,
              size: 32,
            ),
            label: const Text(
              'Resent email',
              style: TextStyle(fontSize: 24.0),
            ),
            onPressed: canResendEmail ? sendVerificationEmail : null,
          ),
          const SizedBox(height: 8.0,),
          TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50.0),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 24.0),
            ),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}
