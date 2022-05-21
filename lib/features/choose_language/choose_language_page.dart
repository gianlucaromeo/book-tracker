import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/choose_language/components/title_top_container.dart';
import 'package:book_tracker/features/choose_language/widgets/choose_language_form.dart';
import 'package:flutter/material.dart';

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({Key? key}) : super(key: key);

  static const _padding = AppPadding.defaultPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              buildTopContainer(),
              buildChooseLanguageForm(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildChooseLanguageForm() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(_padding, 0.0, _padding, _padding),
        child: ChooseLanguageForm(),
      ),
    );
  }

  Padding buildTopContainer() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: WelcomeTitleTopContainer(),
    );
  }
}
