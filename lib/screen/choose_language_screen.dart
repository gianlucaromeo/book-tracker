import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

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
    return Container(
      color: themeController.currentThemeData.backgroundColor,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () => themeController.toggleTheme(),
        child: Text('Toggle Theme'),
      ),
    );
  }
}
