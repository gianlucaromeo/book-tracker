import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/features/onboarding/onboarding_page.dart';
import 'package:book_tracker/util/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NextButton extends StatelessWidget {
  final AppLocalizations l10n;
  const NextButton(this.l10n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          l10n.chooseLanguageNext,
          style: const TextStyle(fontSize: 19.0),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () => Navigator.of(context)
          .push(CustomPageRoute(child: const OnboardingPage())),
    );
  }
}
