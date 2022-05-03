import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/add_book_status_page.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/book_status_util.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class AddStatusActionButtons extends StatelessWidget {
  final GoogleBookModel googleBookModel;
  const AddStatusActionButtons({Key? key, required this.googleBookModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const icons = BookStatusUtil.bookStatusIcons;
    final texts = BookStatusUtil.getBookStatusTexts(context);
    //final colors = BookStatusUtil.bookStatusColors;
    final statusFromType = BookStatusUtil.bookStatusFromType;

    final color = Theme.of(context).colorScheme.background;
    final buttonsData = BookStatusUtil.bookStatusTypes
        .map((status) => [
              icons[status],
              texts[status],
              color, // colors[status],
              statusFromType[status],
            ])
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < buttonsData.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BUTTON
              ClipRect(
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppBorders.defaultBorderRadius),
                    side: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                  ),
                  color: buttonsData[i][2] as Color,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBorders.defaultBorderRadius),
                    splashColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    highlightColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    //splashColor: Colors.green, // splash color
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddBookStatusPage(
                          googleBookModel: googleBookModel,
                          bookStatus: buttonsData[i][3] as BookStatus,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 65,
                      height: 65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            buttonsData[i][0] as IconData,
                            size: 40.0,
                            color: themeController.isDarkTheme
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ), // icon
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TransparentDivider.h(5.0),
              Text(
                buttonsData[i][1] as String,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  //fontWeight: FontWeight.bold,
                  color: themeController.isDarkTheme
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
