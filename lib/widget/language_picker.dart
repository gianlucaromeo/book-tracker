import 'package:book_tracker/provider/locale_provider.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../l10n/l10n.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLanguageName = localeProvider.getCurrentLanguageName(context);
    final supportedLanguagesNames = L10n.getSupportedLanguagesNames(context);

    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Title
        Text(
          l10n.chooseLanguage,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
          ),
        ),

        // -- Dropdown Menu
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.language),
            TransparentDivider.w10(),
            Expanded(
              child: _buildDropdownButton(
                  currentLanguageName, supportedLanguagesNames, context),
            ),
          ],
        ),

        // -- Next Button
        Align(
          child: _buildNextButton(context, l10n),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }

  ElevatedButton _buildNextButton(BuildContext context, AppLocalizations l10n) {
    return ElevatedButton(
      child: Text(
        l10n.chooseLanguageNext,
        style: const TextStyle(
          fontSize: 19.0,
        ),
      ),
      style: TextButton.styleFrom(
        fixedSize: const Size.fromHeight(50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/onboarding_page');
      },
    );
  }

  DropdownButton<String> _buildDropdownButton(String _currentLanguageName,
      List<String> _supportedLanguagesNames, BuildContext context) {
    return DropdownButton(
      value: _currentLanguageName,
      borderRadius: BorderRadius.circular(20.0),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 21.0,
      ),
      items: _supportedLanguagesNames.map((languageName) {
        return DropdownMenuItem(
          value: languageName,
          child: Text(languageName),
          onTap: () {
            Provider.of<LocaleProvider>(context, listen: false).setLocale(
                L10n.getLocaleFromLanguageName(languageName, context));
          },
        );
      }).toList(),
      onChanged: (_) {},
    );
  }
}
