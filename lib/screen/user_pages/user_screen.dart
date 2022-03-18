import 'package:book_tracker/config/general_settings.dart';
import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/constants/bottom_nav_bar_data.dart';
import 'package:book_tracker/screen/user_pages/user_home_page.dart';
import 'package:book_tracker/screen/user_pages/user_mybooks_page.dart';
import 'package:book_tracker/screen/user_pages/user_search_page.dart';
import 'package:book_tracker/screen/user_pages/user_tracker_page.dart';
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
  List<Widget> userPages = const [
    UserHomePage(),
    UserMyBooksPage(),
    UserSearchPage(),
    UserTrackerPage()
  ];

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: _buildAppBar(user, context),
      resizeToAvoidBottomInset:
          false, // to avoid overflow when keyboard shows up
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: userPages[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
      leading: const Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Icon(
          Icons.menu,
          color: Colors.black,
          size: 36,
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
