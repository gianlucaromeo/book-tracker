import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/onboarding/models/onboarding_section_model.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
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
          TransparentDivider.h10(),
          Expanded(child: Lottie.asset(model.assetName)),
          TransparentDivider.h10(),
          buildTitle(),
          TransparentDivider.h10(),
          buildSecondaryTitle(),
          TransparentDivider.h10(),
        ],
      ),
    );
  }

  Text buildTitle() {
    return Text(
      model.title,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 31.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    );
  }

  Text buildSecondaryTitle() {
    return Text(
      model.secondaryTitle,
      maxLines: 2,
      style: TextStyle(
        fontSize: 19.0,
        fontWeight: FontWeight.w600,
        color: themeController.isDarkTheme
            ? DarkThemeData.onPrimary
            : Colors.black.withOpacity(0.5),
      ),
    );
  }
}
