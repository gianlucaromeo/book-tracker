import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/features/choose_language/widgets/language_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ChooseLanguagePage extends StatefulWidget {
  final String _languagesAssetName =
      'assets/introduction/different-languages.json';

  const ChooseLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          //color: Palette.backgroundLight,
          child: Column(
            children: [
              // -- Top Container
              FadeInAnimation(
                milliseconds: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: _buildTopContainer(context),
                ),
              ),

              // -- Language Picker Container
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAppTitleText(context),
                      TransparentDivider.h(15.0),
                      Lottie.asset(
                        widget._languagesAssetName,
                        repeat: false,
                      ),
                      TransparentDivider.h(20.0),
                      FadeInAnimation(
                        child: const LanguagePicker(),
                        milliseconds: 1600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FadeInAnimation _buildAppTitleText(BuildContext context) {
    return FadeInAnimation(
      milliseconds: 1500,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppLocalizations.of(context)!.chooseLanguageTitle,
          style: const TextStyle(
            fontSize: 41.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Container _buildTopContainer(BuildContext context) {
    return Container(
      height: 130.0,
      decoration: BoxDecoration(
        //color: Palette.primaryLight,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      width: double.infinity,
      child: Center(
        child: FadeInAnimation(
          milliseconds: 1200,
          child: Text(
            AppLocalizations.of(context)!.chooseLanguageWelcome,
            style: const TextStyle(
              //color: Colors.white,
              letterSpacing: 1,
              fontSize: 29,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
