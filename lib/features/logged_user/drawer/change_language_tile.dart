import 'package:book_tracker/provider/locale_provider.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeLanguageTile extends StatefulWidget {
  const ChangeLanguageTile({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageTile> createState() => _ChangeLanguageTileState();
}

class _ChangeLanguageTileState extends State<ChangeLanguageTile> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLanguageName = localeProvider.getCurrentLanguageName(context);
    bool englishIsSelected = currentLanguageName == 'English';
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          const Text(
            'Language',
            style: TextStyle(fontSize: 19.0),
          ),
          // LANGUAGE CHOICES
          Row(
            children: [
              TextButton(
                onPressed: () => localeProvider.setLocale(const Locale('en')),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: LightThemeData.primary
                        .withOpacity(englishIsSelected ? 1.0 : 0.5),
                    fontWeight:
                        englishIsSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 17.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => localeProvider.setLocale(const Locale('it')),
                child: Text(
                  'Italian',
                  style: TextStyle(
                    color: LightThemeData.primary
                        .withOpacity(!englishIsSelected ? 1.0 : 0.5),
                    fontWeight: !englishIsSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        //Navigator.of(context).pop();
      },
    );
  }
}
