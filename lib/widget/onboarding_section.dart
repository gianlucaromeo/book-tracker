import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingSection extends StatelessWidget {
  const OnboardingSection(
      {Key? key,
      required this.title,
      required this.secondaryTitle,
      required this.subtitle,
      required this.assetName})
      : super(key: key);

  final String title;
  final String secondaryTitle;
  final String subtitle;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // -- Title
          Align(
            alignment: Alignment.topLeft,
            child: FadeInAnimation(
              milliseconds: 400,
              child: _buildTitle(),
            ),
          ),

          TransparentDivider.h10(),

          // -- Lottie Animation
          Expanded(
            child: FadeInAnimation(
                milliseconds: 900, child: Lottie.asset(assetName)),
          ),

          TransparentDivider.h10(),

          // -- Secondary Title and Subtitle
          FadeInAnimation(
            milliseconds: 1100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSecondaryTitle(),
                TransparentDivider.h(7.0),
                _buildSubtitle(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _buildSubtitle(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 19.0,
        color: Theme.of(context).textTheme.subtitle2!.color,
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 41.0,
        fontWeight: FontWeight.w600,
        color: Palette.titleLight,
        letterSpacing: 1,
      ),
    );
  }

  Text _buildSecondaryTitle() {
    return Text(
      secondaryTitle,
      style: const TextStyle(
        fontSize: 23.0,
        color: Palette.primaryLight,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
