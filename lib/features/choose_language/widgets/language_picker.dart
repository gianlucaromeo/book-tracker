import 'package:book_tracker/features/choose_language/components/next_button.dart';
import 'package:book_tracker/l10n/l10n.dart';
import 'package:book_tracker/provider/locale_provider.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
        buildTitle(l10n),
        buildDropdownMenu(
          currentLanguageName,
          supportedLanguagesNames,
          context,
        ),
        buildNextButton(l10n),
      ],
    );
  }

  Text buildTitle(AppLocalizations l10n) {
    return Text(
      l10n.chooseLanguage,
      style: TextStyles.languagePickerTitle,
    );
  }

  Align buildNextButton(AppLocalizations l10n) {
    return Align(
      child: NextButton(l10n),
      alignment: Alignment.centerRight,
    );
  }

  /// Row with both an icon and a dropdown button.
  Row buildDropdownMenu(
    String currentLanguageName,
    List<String> supportedLanguagesNames,
    BuildContext context,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.language),
          TransparentDivider.w(15.0),
          Expanded(
            child: buildDropdownButton(
                currentLanguageName, supportedLanguagesNames, context),
          ),
        ],
      );

  DropdownButton<String> buildDropdownButton(
    String currentLanguageName,
    List<String> supportedLanguagesNames,
    BuildContext context,
  ) =>
      DropdownButton(
        itemHeight: 70.0,
        value: currentLanguageName,
        borderRadius: BorderRadius.circular(10.0),
        style: TextStyles.languagePickerDropdownButton,
        items: supportedLanguagesNames.map((languageName) {
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
