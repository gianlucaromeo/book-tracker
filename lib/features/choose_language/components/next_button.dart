import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NextButton extends StatelessWidget {
  final AppLocalizations l10n;
  const NextButton(this.l10n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        l10n.chooseLanguageNext,
        style: TextStyles.languagePickerNextButton,
      ),
      style: TextButton.styleFrom(
        fixedSize: const Size.fromHeight(50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () =>
          Navigator.of(context).pushNamed(Routes.onboardingPageRouteName),
    );
  }
}
