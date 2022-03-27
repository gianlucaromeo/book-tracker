import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/onboarding/models/onboarding_section_model.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingSection extends StatelessWidget {
  const OnboardingSection({Key? key, required this.model}) : super(key: key);

  final OnboardingSectionModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TITLE
          Align(
            alignment: Alignment.topLeft,
            child: buildTitle(),
          ),
          TransparentDivider.h10(),
          // LOTTIE ANIMATION
          Expanded(
            child: Lottie.asset(model.assetName),
          ),
          TransparentDivider.h10(),
          // SECONDARY TITLE AND SUBTITLE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSecondaryTitle(),
              TransparentDivider.h10(),
              buildSubtitle(context),
            ],
          ),
        ],
      ),
    );
  }

  Text buildSubtitle(BuildContext context) {
    return Text(
      model.subtitle,
      style: TextStyles.onboardingSectionSubtitle,
    );
  }

  Text buildTitle() {
    return Text(
      model.title,
      style: TextStyles.onboardingSectionTitle,
    );
  }

  Text buildSecondaryTitle() {
    return Text(
      model.secondaryTitle,
      style: TextStyles.onboardingSectionSecondaryTitle,
    );
  }
}
