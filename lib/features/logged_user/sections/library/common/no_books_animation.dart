import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoBooksAnimation extends StatelessWidget {
  const NoBooksAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: Lottie.asset(
              'assets/logged_user/no_books.json',
            ),
          ),
          TransparentDivider.h(AppPadding.defaultPadding / 2),
          Text(
            'No books.',
            style:
                Theme.of(context).textTheme.overline!.copyWith(fontSize: 19.0),
          ),
        ],
      ),
    );
  }
}
