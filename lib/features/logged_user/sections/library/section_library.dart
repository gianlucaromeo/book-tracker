import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/currently_reading_section.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/read_section.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/to_read_section.dart';
import 'package:flutter/material.dart';

class UserSectionLibrary extends StatefulWidget {
  const UserSectionLibrary({Key? key}) : super(key: key);

  @override
  _UserSectionLibraryState createState() => _UserSectionLibraryState();
}

class _UserSectionLibraryState extends State<UserSectionLibrary> {
  final sections = const [
    BooksCurrentlyReadingSection(),
    BooksReadSection(),
    BooksToReadSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections
            .map((section) => Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppPadding.defaultPadding / 2),
                  child: section,
                ))
            .toList(),
      ),
    );
  }
}
