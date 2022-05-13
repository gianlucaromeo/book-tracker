import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDescriptionInfo extends StatelessWidget {
  const NoDescriptionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/logged_user/no_description_error.json',
            height: 150,
            width: 220,
          ),
          TransparentDivider.h(AppPadding.defaultPadding / 2),
          const Text(
            'No description',
            maxLines: 2,
            style: TextStyle(
              fontSize: 23.0,
            ),
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          const Text(
            'Unfortunately, no description has been provided for this book, but you can add it to your library.',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
