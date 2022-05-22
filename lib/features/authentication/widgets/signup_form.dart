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
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late AppLocalizations _l10n;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _signUpError = false;

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
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransparentDivider.h(AppPadding.defaultPadding),
            // EMAIL FIELD
            buildEmailField(),
            TransparentDivider.h(AppPadding.defaultPadding),
            // PASSWORD FIELD
            buildPasswordField(
              _passwordController,
              _l10n.signUpFormPasswordLabelText,
              _passwordValidator,
            ),
            TransparentDivider.h(AppPadding.defaultPadding / 2),
            if (!_signUpError)
              Text(
                ' Password must contain at least 6 characters.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 15,
                ),
              ),
            if (!_signUpError)
              TransparentDivider.h(AppPadding.defaultPadding / 2),
            // CONFIRM PASSWORD FIELD
            buildPasswordField(
              _confirmPasswordController,
              _l10n.signUpFormConfirmPasswordLabelText,
              _confirmPasswordValidator,
            ),
            TransparentDivider.h(AppPadding.defaultPadding),
            // SIGN UP WITH EMAIL BUTTON
            buildDoSignUpButton(),
            const Divider(
              height: 40,
              thickness: 1,
            ),
            // GOOGLE SIGN UP BUTTON
            const GoogleSignInButton(),
          ],
        ),
      ),
    );
  }

  Align buildGoToLoginTopLink() => Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () {}, // widget.onSignInClicked,
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
        text: _l10n.signUpFormAlreadyHaveAnAccount,
        style: TextStyles.switchAuthFormLink,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = null, //! widget.onSignInClicked,
            text: _l10n.signUpFormLoginText,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black.withOpacity(0.5),
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  buildDoSignUpButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //minimumSize: const Size.fromHeight(LoginSignUpFormSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(LoginSignUpFormSizes.buttonBorderRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.defaultPadding / 2),
          child: Text(
            _l10n.signUpFormSignUpButtonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            ),
          ),
        ),
        onPressed: _doSignUp,
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: _l10n.signUpFormEmailLabelText,
        focusedBorder: LoginSignUpFormSizes.border,
        enabledBorder: LoginSignUpFormSizes.border,
        border: LoginSignUpFormSizes.border,
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
          focusedBorder: LoginSignUpFormSizes.border,
          enabledBorder: LoginSignUpFormSizes.border,
          border: LoginSignUpFormSizes.border,
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
    if (!isValid) {
      setState(() {
        _signUpError = true;
        return;
      });
    }

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
    } on FirebaseAuthException {
      setState(() {
        _signUpError = true;
      });
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
