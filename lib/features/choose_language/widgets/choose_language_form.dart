import 'package:book_tracker/features/choose_language/components/app_title.dart';
import 'package:book_tracker/features/choose_language/widgets/language_picker.dart';
import 'package:book_tracker/features/choose_language/data/choose_language_data.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChooseLanguageForm extends StatelessWidget {
  const ChooseLanguageForm({Key? key}) : super(key: key);

  static final _divider = TransparentDivider.h(20.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppTitle(),
        _divider,
        Lottie.asset(
          ChooseLanguageData.chooseLanguageAssetName,
          repeat: false,
        ),
        _divider,
        const LanguagePicker(),
      ],
    );
  }
}
