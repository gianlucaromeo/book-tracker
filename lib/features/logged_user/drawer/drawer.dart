import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
