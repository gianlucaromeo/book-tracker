import 'package:book_tracker/widget/onboarding_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingSectionsData {
  
  static const _firstSectionAssetName = 'assets/onboarding/onboarding_first.json';
  static const _secondSectionAssetName = 'assets/onboarding/onboarding_charts.json';
  static const _thirdSectionAssetName = 'assets/onboarding/onboarding_ready_to_start.json';
  
  static List<OnboardingSection> getSections(BuildContext context) {
    
    final l10n = AppLocalizations.of(context)!;
    
    return [

      // -- Section 1
      OnboardingSection(
        title: l10n.onboardingTitle1,
        subtitle: l10n.onboardingSubtitle1,
        secondaryTitle:
        l10n.onboardingSecondaryTitle1,
        assetName: _firstSectionAssetName,
      ),

      // -- Section 2
      OnboardingSection(
        title: l10n.onboardingTitle2,
        subtitle: l10n.onboardingSubtitle2,
        secondaryTitle:
        l10n.onboardingSecondaryTitle2,
        assetName: _secondSectionAssetName,
      ),

      // -- Section 3
      OnboardingSection(
        title: l10n.onboardingTitle3,
        subtitle: l10n.onboardingSubtitle3,
        secondaryTitle:
        l10n.onboardingSecondaryTitle3,
        assetName: _thirdSectionAssetName,
      )

    ];

  } // end getSections
  
}