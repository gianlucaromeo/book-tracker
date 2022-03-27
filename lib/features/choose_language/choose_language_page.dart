import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/choose_language/components/title_top_container.dart';
import 'package:book_tracker/features/choose_language/widgets/choose_language_form.dart';
import 'package:flutter/material.dart';

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = AppPadding.defaultPadding;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              buildTopContainer(padding),
              buildChooseLanguageForm(padding),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildChooseLanguageForm(double padding) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 0.0, padding, padding),
        child: const ChooseLanguageForm(),
      ),
    );
  }

  Padding buildTopContainer(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: const WelcomeTitleTopContainer(),
    );
  }
}
