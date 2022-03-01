import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/main.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TransparentDivider.h10(),
              FadeInAnimation(child: _buildTitle(), milliseconds: 500,),

              TransparentDivider.h(10.0),
              FadeInAnimation(child: _buildSubtitle(), milliseconds: 500,),


              TransparentDivider.h(20.0),
              FadeInAnimation(child: _buildEmailField(), milliseconds: 500,),


              TransparentDivider.h(20.0),
              FadeInAnimation(child: _buildResetPasswordButton(), milliseconds: 500,),


              TransparentDivider.h(20.0),

              Expanded(
                child: FadeInAnimation(child: Lottie.asset('assets/authentication/forgot_password.json'), milliseconds: 500,),
              ),
            ],
          ),
        ),
      ),
    );
  }


  TextFormField _buildEmailField() {
    return TextFormField(
      controller: emailController,
      cursorColor: Colors.blueAccent,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Enter a valid email'
          : null,
    );
  }

  Align _buildSubtitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'An email be sent to recover your password.',
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }

  Align _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Reset Password',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 31.0,
        ),
      ),
    );
  }

  ElevatedButton _buildResetPasswordButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(71.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const Icon(
        Icons.email_outlined,
        size: 32.0,
      ),
      label: const Text(
        'Reset Password',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      onPressed: resetPassword,
    );
  }

  Future resetPassword() async {
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
        'Password Recovery',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 27.0,
          letterSpacing: 1,
        ),
      ),
      iconTheme: const IconThemeData(
        size: 40.0,
        color: Colors.white,
      ),
    );
  }
}
