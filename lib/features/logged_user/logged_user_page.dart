import 'package:book_tracker/config/general.dart';
import 'package:book_tracker/features/logged_user/data/bottom_nav_bar_data.dart';
import 'package:book_tracker/features/logged_user/sections/home/section_home.dart';
import 'package:book_tracker/features/logged_user/sections/library/section_library.dart';
import 'package:book_tracker/features/logged_user/sections/search/section_search.dart';
import 'package:book_tracker/features/logged_user/sections/tracker/section_tracker.dart';
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

  List<Widget> userPages = const [
    UserSectionHome(),
    UserSectionMyBooks(),
    UserSectionSearch(),
    UserSectionTracker()
  ];

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(user, context),
      resizeToAvoidBottomInset:
          false, // to avoid overflow when keyboard shows up
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: userPages[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.of(context).pop();
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

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 31.0,
      backgroundColor: Colors.white60,
      selectedItemColor: Colors.black,
      currentIndex: _currentIndex,
      onTap: (index) => setState(() {
        _currentIndex = index;
      }),
      items: BottomNavBarData.getItems(context),
    );
  }

  AppBar _buildAppBar(User user, BuildContext context) {
    return AppBar(
      title: _currentIndex == 0
          ? Text(
              //'${user.displayName ?? user.email}',
              'Book Tracker',
              style: TextStyle(
                fontFamily: GeneralSettings.textStyle.fontFamily,
              ),
            )
          : const Text(''),
      toolbarHeight: 80.0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 23),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black, size: 36),
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
              color: Colors.black,
              size: 36,
            ),
          ),
        ),
        TransparentDivider.w(10.0),
      ],
    );
  }
}
