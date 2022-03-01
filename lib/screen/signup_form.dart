import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/widget/google_sign_in_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../provider/google_sign_in_provider.dart';
import '../util/fade_animation.dart';

class SignUpForm extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpForm({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // -- Title
              FadeInAnimation(child: _buildTitle(), milliseconds: 500,),


              TransparentDivider.h(30.0),

              // -- Email Field
              FadeInAnimation(child: _buildEmailField(), milliseconds: 500,),


              TransparentDivider.h(22.0),

              // -- Password Field
              FadeInAnimation(child: _buildPasswordField(
                  _passwordController, 'Password', _passwordValidator), milliseconds: 500,),

              TransparentDivider.h(22.0),

              // -- Confirm Password Field
              FadeInAnimation(child: _buildPasswordField(_confirmPasswordController,
                  'Confirm Password', _confirmPasswordValidator), milliseconds: 500,),

              TransparentDivider.h(22.0),

              // -- Sign Up with Email Button
              FadeInAnimation(child: _buildSignUpButton(), milliseconds: 500,),


              const Divider(
                height: 40,
                thickness: 1,
              ),

              // -- Sign In with Google Button
              FadeInAnimation(child: const GoogleSignInButton(), milliseconds: 500,),


              TransparentDivider.h(22.0),

              // -- Go to Login Page
              FadeInAnimation(child: _buildGoToLoginPage(context), milliseconds: 500,),


            ],
          ),
        ),
      ),
    );
  }

  RichText _buildGoToLoginPage(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20.0,
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
        text: 'Already have an account? ',
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
            text: 'Login',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildSignUpButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      icon: const Icon(
        Icons.arrow_right_alt,
        size: 32.0,
      ),
      label: const Text(
        'Sign Up',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      onPressed: signUp,
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Enter a valid email'
          : null,
    );
  }

  Align _buildTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Sign Up',
        style: TextStyle(
          fontSize: 32.0,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextFormField _buildPasswordField(TextEditingController _controller,
      String labelText, String? Function(String?) validator) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }

  String? _passwordValidator(password) =>
      password != null && password.length < 6
          ? 'Must contain at least 6 characters'
          : null;

  String? _confirmPasswordValidator(confirmPassword) =>
      confirmPassword != _passwordController.text.trim()
          ? 'Passwords dont match'
          : null;

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
