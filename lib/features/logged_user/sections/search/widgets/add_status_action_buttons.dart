import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/add_book_status_page.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class AddStatusActionButtons extends StatelessWidget {
  final GoogleBookModel googleBookModel;
  const AddStatusActionButtons({Key? key, required this.googleBookModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const opacity = 0.7;
    final buttonsData = [
      [
        Icons.done,
        "Read",
        Colors.green.withOpacity(opacity),
        BookStatusRead(),
      ], // READ
      [
        Icons.timelapse,
        "Currently reading",
        Colors.orange.withOpacity(opacity),
        BookStatusCurrentlyReading(),
      ], // CURRENTLY READING
      [
        Icons.calendar_today,
        "To read",
        Colors.pink.withOpacity(opacity),
        BookStatusToRead(),
      ], // TO READ
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppBorders.defaultBorderRadius)),
                  color: buttonsData[i][2] as Color,
                  child: InkWell(
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
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            buttonsData[i][0] as IconData,
                            size: 50.0,
                            color: Colors.white,
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
      ],
    );
  }
}
