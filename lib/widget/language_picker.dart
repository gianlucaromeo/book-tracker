import 'package:book_tracker/provider/locale_provider.dart';
import 'package:book_tracker/util/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../l10n/l10n.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _currentLanguageName = Provider.of<LocaleProvider>(context).getCurrentLanguageName(context);
    final _supportedLanguagesNames = L10n.getSupportedLanguagesNames(context);

    return FadeAnimation(
      duration: const Duration(milliseconds: 1200),
      opacityFrom: 0.0,
      opacityTo: 1.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Lottie.asset('assets/introduction/world.json',height: 100.0, width: 100.0),
            Text(
              AppLocalizations.of(context)!.chooseLanguage,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: DropdownButton(
                    value: _currentLanguageName,
                    borderRadius: BorderRadius.circular(20.0),
                    dropdownColor: Colors.white,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 21.0,
                    ),
                    elevation: 1,
                    items: _supportedLanguagesNames.map((languageName) {
                      return DropdownMenuItem(
                        value: languageName,
                        child: Text(languageName),
                        onTap: () {
                          Provider.of<LocaleProvider>(context, listen: false)
                              .setLocale(L10n.getLocaleFromLanguageName(
                                  languageName, context));
                        },
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            Align(
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(context)!.chooseLanguageNext,
                  style: const TextStyle(
                    fontSize: 19.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  fixedSize: const Size.fromHeight(50.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () {},
              ),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }

}
