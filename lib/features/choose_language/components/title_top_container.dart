import 'package:book_tracker/config/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A welcome title wrapped inside a container.
class WelcomeTitleTopContainer extends StatelessWidget {
  const WelcomeTitleTopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppContainer.defaultHeight,
      decoration: AppContainer.defaultDecorationWithBottomRadius,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        AppLocalizations.of(context)!.chooseLanguageWelcome,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
