import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/features/onboarding/models/onboarding_section_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingSection extends StatelessWidget {
  const OnboardingSection({Key? key, required this.model}) : super(key: key);

  final OnboardingSectionModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // TITLE
          Align(
            alignment: Alignment.topLeft,
            child: FadeInAnimation(
              milliseconds: 400,
              child: buildTitle(),
            ),
          ),

          TransparentDivider.h10(),

          // LOTTIE ANIMATION
          Expanded(
            child: FadeInAnimation(
                milliseconds: 900, child: Lottie.asset(model.assetName)),
          ),

          TransparentDivider.h10(),

          // -- SECONDARY TITLE AND SUBTITLE
          FadeInAnimation(
            milliseconds: 1100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSecondaryTitle(),
                TransparentDivider.h(7.0),
                buildSubtitle(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text buildSubtitle(BuildContext context) {
    return Text(
      model.subtitle,
      style: TextStyle(
        fontSize: 19.0,
        //color: Theme.of(context).textTheme.subtitle2!.color,
      ),
    );
  }

  Text buildTitle() {
    return Text(
      model.title,
      style: const TextStyle(
        fontSize: 41.0,
        fontWeight: FontWeight.w600,
        //color: Palette.titleLight,
        letterSpacing: 1,
      ),
    );
  }

  Text buildSecondaryTitle() {
    return Text(
      model.secondaryTitle,
      style: const TextStyle(
        fontSize: 23.0,
        //color: Palette.primaryLight,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
