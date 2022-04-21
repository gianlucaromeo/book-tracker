import 'package:flutter/material.dart';

class SetStatusButton extends StatelessWidget {
  const SetStatusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.fromSize(
        size: Size(100, 100), // button width and height
        child: ClipRect(
          child: Material(
            color: Colors.grey.withOpacity(0.2),
            child: InkWell(
              //splashColor: Colors.green, // splash color
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.call), // icon
                  Text("Currently Reading"), // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
