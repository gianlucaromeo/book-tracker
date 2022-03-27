import 'package:book_tracker/config/general.dart';
import 'package:book_tracker/features/logged_user/data/bottom_nav_bar_data.dart';
import 'package:book_tracker/features/logged_user/sections/home/section_home.dart';
import 'package:book_tracker/features/logged_user/sections/library/section_library.dart';
import 'package:book_tracker/features/logged_user/sections/search/section_search.dart';
import 'package:book_tracker/features/logged_user/sections/tracker/section_tracker.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
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

  List<Widget> userSections = const [
    UserSectionHome(),
    UserSectionMyBooks(),
    UserSectionSearch(),
    UserSectionTracker()
  ];

  int _currentSectionIndex = 2;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(user, context),
      resizeToAvoidBottomInset:
          false, // to avoid overflow when keyboard shows up
      body: Container(
        alignment: Alignment.topCenter,
        child: userSections[_currentSectionIndex],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  //color: Colors.blue,
                  ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Change Theme'),
              onTap: () {
                // Update the state of the app.
                // ...
                themeController.toggleTheme();
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 31.0,
      currentIndex: _currentSectionIndex,
      onTap: (index) => setState(() {
        _currentSectionIndex = index;
      }),
      items: BottomNavBarData.getItems(context),
    );
  }

  AppBar buildAppBar(User user, BuildContext context) {
    return AppBar(
      title: Text(
        'Book tracker', //${user.displayName ?? user.email}',
        style: TextStyle(
          fontFamily: GeneralSettings.textStyle.fontFamily,
          fontSize: 23.0,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: IconButton(
          icon: const Icon(Icons.menu, size: 36),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
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
            icon: const Icon(
              Icons.logout,
              size: 36,
            ),
          ),
        ),
        TransparentDivider.w(10.0),
      ],
    );
  }
}
