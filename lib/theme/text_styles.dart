import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static Color _detectColor() {
    return themeController.currentThemeMode == ThemeMode.light
        ? Colors.black
        : Colors.white;
  }

  /* CHOOSE LANGUAGE PAGE */
  static get chooseLanguageTopContainer => const TextStyle(
        letterSpacing: 2,
        fontSize: 24,
        fontWeight: FontWeight.normal,
      );

  static get chooseLanguageAppTitle => const TextStyle(
        fontSize: 41.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      );

  static get languagePickerTitle => const TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.w500,
      );

  static get languagePickerDropdownButton => TextStyle(
        fontSize: 21.0,
        color: _detectColor(),
      );

  static get languagePickerNextButton => const TextStyle(
        fontSize: 19.0,
      );
  /* END CHOOSE LANGUAGE PAGE */

  /* ONBOARDING PAGE */
  static get onboardingSectionTitle => const TextStyle(
        fontSize: 41.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      );

  static get onboardingSectionSecondaryTitle => const TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.w600,
      );

  static get onboardingSectionSubtitle => const TextStyle(
        fontSize: 19.0,
      );

  static get onboardingLastPageButton => TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        color: _detectColor(),
      );

  static get onboardingBottomButton => const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      );
  /* END ONBOARDING PAGE */

  /* AUTHENTICATION PAGE */
  static get authPageFormTitle => const TextStyle(
        fontSize: 32.0,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      );

  static get authPageAppBarTitle => const TextStyle(
        //color: _detectColor(),
        letterSpacing: 1,
        fontWeight: FontWeight.w400,
        fontSize: 24.0,
      );

  static get signupFormGoToLoginTopLink => const TextStyle(fontSize: 19.0);

  static get switchAuthFormLink => TextStyle(
        fontSize: 20.0,
        color: _detectColor().withOpacity(0.6),
      );

  static get authFormButton => const TextStyle(
        fontSize: 24.0,
      );

  static get loginFormForgotPasswordLink => TextStyle(
        decoration: TextDecoration.underline,
        color: _detectColor(),
        fontSize: 20.0,
      );

  static get forgotPasswordTitle => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 31.0,
      );

  static get forgotPasswordSubtitle => const TextStyle(
        fontSize: 18.0,
      );

  static get confirmEmailTitle => const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      );

  static get confirmEmailSubtitle => const TextStyle(
        fontSize: 20.0,
      );

  static get confirmEmailResendEmail => const TextStyle(
        fontSize: 24.0,
      );

  static get confirmEmailBackToLoginButton => const TextStyle(
        fontSize: 24.0,
      );
  /* END AUTHENTICATION PAGE */

  /* SEARCH PAGE */
  static get searchBookFieldHintText => const TextStyle(
        fontSize: 19.0,
      );

  static get searchPageTrendingBooksTitle => const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      );
  static get searchPagePopularBooksTitle => searchPageTrendingBooksTitle;
  /* END SEARCH PAGE */

}
