import 'package:book_tracker/features/onboarding/models/onboarding_section_model.dart';
import 'package:book_tracker/features/onboarding/widgets/onboarding_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingSectionsData {
  static final _assetsNames = [
    'assets/onboarding/onboarding_first.json',
    'assets/onboarding/onboarding_charts.json',
    'assets/onboarding/onboarding3.json'
  ];

  static List<OnboardingSection> getOnboardingSections(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final data = [
      // Section 1
      [
        l10n.onboardingTitle1,
        l10n.onboardingSecondaryTitle1,
      ],
      // Section 2
      [
        l10n.onboardingTitle2,
        l10n.onboardingSecondaryTitle2,
      ],
      // Section 3
      [
        l10n.onboardingTitle3,
        l10n.onboardingSecondaryTitle3,
      ],
    ];

    return List.generate(
      data.length,
      (index) => OnboardingSection(
        model: OnboardingSectionModel(
          title: data[index][0],
          secondaryTitle: data[index][1],
          assetName: _assetsNames[index],
        ),
      ),
    );
  }
}
