import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/features/authentication/widgets/google_sign_in_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';
import '../../../util/fade_animation.dart';

class SignUpForm extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpForm({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  late final AppLocalizations _l10n;
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
    const int _milliseconds = 100;
    _l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              // -- Go To Login
              FadeInAnimation(
                milliseconds: 500,
                child: _buildGoToLoginText(),
              ),
              TransparentDivider.h(15.0),


              // -- Title
              FadeInAnimation(
                child: _buildTitle(),
                milliseconds: _milliseconds,
              ),
              TransparentDivider.h(30.0),

              // -- Email Field
              FadeInAnimation(
                child: _buildEmailField(),
                milliseconds: _milliseconds,
              ),
              TransparentDivider.h(10.0),

              // -- Password Field
              FadeInAnimation(
                child: _buildPasswordField(
                    _passwordController, _l10n.signUpFormPasswordLabelText, _passwordValidator),
                milliseconds: _milliseconds,
              ),
              TransparentDivider.h(10.0),

              // -- Confirm Password Field
              FadeInAnimation(
                child: _buildPasswordField(_confirmPasswordController,
                    _l10n.signUpFormConfirmPasswordLabelText, _confirmPasswordValidator),
                milliseconds: _milliseconds,
              ),
              TransparentDivider.h(18.0),

              // -- Sign Up with Email Button
              FadeInAnimation(
                child: _buildSignUpButton(),
                milliseconds: _milliseconds,
              ),

              const Divider(
                height: 40,
                thickness: 1,
              ),

              // -- Sign In with Google Button
              FadeInAnimation(
                child: const GoogleSignInButton(),
                milliseconds: _milliseconds,
              ),
              TransparentDivider.h(22.0),

              // -- Go to Login Page
              FadeInAnimation(
                child: _buildGoToLoginPage(context),
                milliseconds: _milliseconds,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildGoToLoginText() => Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: widget.onClickedSignIn,
          icon: const Icon(Icons.arrow_back),
          label: Text(
            _l10n.signUpFormGoToLoginText,
            style: const TextStyle(fontSize: 19.0),
          ),
        ),
      );

  RichText _buildGoToLoginPage(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20.0,
          //color: Theme.of(context).textTheme.subtitle1!.color,
        ),
        text: _l10n.signUpFormAlreadyHaveAnAccount,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
            text: _l10n.signUpFormLoginText,
            style: TextStyle(
              decoration: TextDecoration.underline,
             // color: Theme.of(context).colorScheme.primary,
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
      label: Text(
        _l10n.signUpFormSignUpButtonText,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      onPressed: signUp,
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      //cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.signUpFormEmailLabelText,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? _l10n.signUpFormEmailErrorText
          : null,
    );
  }

  Align _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _l10n.signUpFormTitle,
        style: const TextStyle(
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
      //cursorColor: Colors.white,
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
          ? _l10n.signUpFormPasswordLengthError
          : null;

  String? _confirmPasswordValidator(confirmPassword) =>
      confirmPassword != _passwordController.text.trim()
          ? _l10n.signUpFormPasswordsDontMatchError
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
