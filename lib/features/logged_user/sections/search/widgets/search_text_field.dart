import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget with ChangeNotifier {
  String _bookToFind = '';

  String get bookToFind => _bookToFind;

  SearchTextField({Key? key}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  static const iconSize = 40.0;

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppBorders.defaultBorderRadius),
      ),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.shadow,
      ),
    );

    final iconColor = Theme.of(context).iconTheme.color!.withOpacity(0.2);

    return TextField(
      controller: _textController,
      onChanged: (newText) {
        setState(() {
          widget._bookToFind = newText;
          widget.notifyListeners();
        });
      },
      //style: TextStyles.searchBookFieldHintText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(AppPadding.defaultPadding),
        hintText: 'Search...',
        enabledBorder: _border,
        focusedBorder: _border,
        border: _border,
        /* ========= PREFIX / SUFFIX ICONS ========= */
        prefixIcon: Padding(
          padding: const EdgeInsets.all(AppPadding.defaultPadding / 2),
          child: Icon(Icons.search, size: iconSize, color: iconColor),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
              bottom: AppPadding.defaultPadding / 2 - 5, // ! TO CENTER
              right: AppPadding.defaultPadding / 2),
          child: IconButton(
            onPressed: () {
              _textController.clear();
              setState(() {
                widget._bookToFind = '';
                widget.notifyListeners();
              });
            },
            icon: Icon(Icons.clear_rounded, size: iconSize, color: iconColor),
          ),
        ),
        /* ========= END PREFIX / SUFFIX ICONS ========= */
      ),
    );
  }
}
