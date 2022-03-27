import 'package:book_tracker/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A welcome title wrapped inside a container.
class WelcomeTitleTopContainer extends StatelessWidget {
  const WelcomeTitleTopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = 20.0;
    return Container(
      height: 130.0,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
      ),
      width: double.infinity, // * COVER REMAINING SPACE
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppLocalizations.of(context)!.chooseLanguageWelcome,
          style: TextStyles.chooseLanguageTopContainer,
        ),
      ),
    );
  }
}
