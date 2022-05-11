import 'package:book_tracker/features/logged_user/sections/library/widget/books_read_list.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class UserSectionLibrary extends StatefulWidget {
  const UserSectionLibrary({Key? key}) : super(key: key);

  @override
  _UserSectionLibraryState createState() => _UserSectionLibraryState();
}

class _UserSectionLibraryState extends State<UserSectionLibrary>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            tabs: List.from(
              ['All', 'Read', 'Currently reading', 'To read'].map(
                (title) => Tab(
                  text: title,
                ),
              ),
            )),
        TransparentDivider.h(20),
        Expanded(
          child: TabBarView(
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            children: List.generate(4, (index) => const BooksReadList()),
          ),
        ),
      ],
    );
  }
}
