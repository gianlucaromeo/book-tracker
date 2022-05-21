import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/data/bottom_nav_bar_data.dart';
import 'package:book_tracker/features/logged_user/drawer/drawer.dart';
import 'package:book_tracker/features/logged_user/sections/home/section_home.dart';
import 'package:book_tracker/features/logged_user/sections/library/section_library.dart';
import 'package:book_tracker/features/logged_user/sections/search/section_search.dart';
import 'package:book_tracker/features/logged_user/sections/tracker/section_tracker.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/google_sign_in_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> userSections = const [
    UserSectionHome(),
    UserSectionLibrary(),
    UserSectionSearch(),
    UserSectionTracker()
  ];

  int _currentSectionIndex = 2;

  @override
  void initState() {
    super.initState();
    themeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(user),
      // to avoid overflow when keyboard shows up:
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(AppPadding.defaultPadding,
            AppPadding.defaultPadding, AppPadding.defaultPadding, 0),
        alignment: Alignment.topLeft,
        child: userSections[_currentSectionIndex],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      drawer: const AppDrawer(),
    );
  }

  buildBottomNavigationBar() => BottomNavigationBar(
        currentIndex: _currentSectionIndex,
        onTap: (index) => setState(() {
          _currentSectionIndex = index;
        }),
        items: BottomNavBarData.items,
      );

  buildAppBar(User user) => AppBar(
        title: _currentSectionIndex == 1 ? Text('Library') : null,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppPadding.defaultPadding - 10),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: AppPadding.defaultPadding - 10),
            child: IconButton(
              onPressed: () {
                final String providerId = user.providerData[0].providerId;
                if (providerId == 'google.com') {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                } else {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: const Icon(Icons.notifications_none_outlined),
            ),
          ),
        ],
      );
}
