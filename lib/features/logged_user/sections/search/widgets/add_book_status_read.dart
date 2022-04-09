import 'package:flutter/material.dart';

class AddBookStatusRead extends StatelessWidget {
  const AddBookStatusRead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          // GO BACK
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Go back'),
          ),
          // DATE BUTTONS
          Expanded(
            child: Row(
              children: [
                // DATE START BUTTON
                ElevatedButton(
                  onPressed: () {
                    showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 600)),
                    );
                  },
                  child: const Text('Start Date'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
