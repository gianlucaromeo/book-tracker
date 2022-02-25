import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Palette.backgroundLight,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Lottie.asset(
                'assets/introduction/different-languages.json',
                repeat: false,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
