import 'package:flutter/material.dart';

class UserSectionHome extends StatelessWidget {
  const UserSectionHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        ),
        itemBuilder: (context, index) {
          return IconButton(
            iconSize: 51.0,
            icon: const Icon(Icons.bar_chart),
            onPressed: () {},
          );
      },
      ),
    );
  }
}
