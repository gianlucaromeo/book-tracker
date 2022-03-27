import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/authentication/login_signup_common/sizes.dart';
import 'package:book_tracker/features/authentication/widgets/google_sign_in_button.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';

class SignUpForm extends StatefulWidget {
  final VoidCallback onSignInClicked;
  const SignUpForm({Key? key, required this.onSignInClicked}) : super(key: key);

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
    _l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GO TO LOGIN LINK
              buildGoToLoginTopLink(),
              TransparentDivider.h(15.0),
              // FORM TITLE
              buildTitle(),
              TransparentDivider.h(30.0),
              // EMAIL FIELD
              buildEmailField(),
              TransparentDivider.h(10.0),
              // PASSWORD FIELD
              buildPasswordField(
                _passwordController,
                _l10n.signUpFormPasswordLabelText,
                _passwordValidator,
              ),
              TransparentDivider.h(10.0),
              // CONFIRM PASSWORD FIELD
              buildPasswordField(
                _confirmPasswordController,
                _l10n.signUpFormConfirmPasswordLabelText,
                _confirmPasswordValidator,
              ),
              TransparentDivider.h(18.0),
              // SIGN UP WITH EMAIL BUTTON
              buildSignUpButton(),
              const Divider(
                height: 40,
                thickness: 1,
              ),
              // GOOGLE SIGN UP BUTTON
              const GoogleSignInButton(),
              TransparentDivider.h(22.0),
              // GO TO LOGIN LINK
              buildGoToLoginBottomLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Align buildGoToLoginTopLink() => Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: widget.onSignInClicked,
          icon: const Icon(Icons.arrow_back),
          label: Text(
            _l10n.signUpFormGoToLoginText,
            style: TextStyles.signupFormGoToLoginTopLink,
          ),
        ),
      );

  RichText buildGoToLoginBottomLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyles.switchAuthFormLink,
        text: _l10n.signUpFormAlreadyHaveAnAccount,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = widget.onSignInClicked,
            text: _l10n.signUpFormLoginText,
            // No need for this TextStyle to be inside the TextStyles class
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildSignUpButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(LoginSignUpFormSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
        ),
      ),
      icon: const Icon(
        Icons.arrow_right_alt,
        size: LoginSignUpFormSizes.buttonIconSize,
      ),
      label: Text(
        _l10n.signUpFormSignUpButtonText,
        style: TextStyles.authFormButton,
      ),
      onPressed: _doSignUp,
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
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

  Align buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        _l10n.signUpFormTitle,
        style: TextStyles.authPageFormTitle,
      ),
    );
  }

  TextFormField buildPasswordField(
    TextEditingController controller,
    String labelText,
    String? Function(String?) validator,
  ) =>
      TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        obscureText: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      );

  String? _passwordValidator(password) =>
      password != null && password.length < 6
          ? _l10n.signUpFormPasswordLengthError
          : null;

  String? _confirmPasswordValidator(confirmPassword) =>
      confirmPassword != _passwordController.text.trim()
          ? _l10n.signUpFormPasswordsDontMatchError
          : null;

  Future _doSignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
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
