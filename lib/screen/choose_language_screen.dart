import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/l10n/l10n.dart';
import 'package:book_tracker/provider/locale_provider.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:book_tracker/widget/language_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChooseLanguagePage extends StatefulWidget {
  const ChooseLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {

  @override
  void initState() {
    themeController.addListener(() {setState(() {});});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _currentLocale = Provider.of<LocaleProvider>(context).currentLocale;
    final _supportedLocalesNames = [
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.italian,
    ];

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Palette.backgroundLight,
        child: Column(
          children: [
            Container(
              height: 130.0,
              decoration: BoxDecoration(
                color: themeController.lightThemeData.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0), bottomRight: Radius.circular(100.0)),
              ),
              width: double.infinity,
              child: Center(
                child: FadeAnimation(
                  duration: const Duration(milliseconds: 1300),
                  opacityFrom: 0.0,
                  opacityTo: 1.0,
                  child: Text(
                    AppLocalizations.of(context)!.chooseLanguageWelcome,
                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 29,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 50.0),
                    child: FadeAnimation(
                      opacityFrom: 0.0,
                      opacityTo: 1.0,
                      duration: const Duration(seconds: 2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.chooseLanguageTitle,
                          style: const TextStyle(
                            fontSize: 38.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                      opacityFrom: 0.0,
                      opacityTo: 1.0,
                      child: const LanguagePicker(),
                      duration: const Duration(milliseconds: 500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                    child: Lottie.asset(
                      'assets/introduction/different-languages.json',
                      repeat: false,
                    ),
                  ),

                ],
              ),
           ),

          ],
        ),
      ),
    );
  }
}
