import 'package:flutter/material.dart';

class RatingsContainer extends StatefulWidget with ChangeNotifier {
  int? selectedRating;

  setRating(int newRating) {
    if (selectedRating == null) {
      selectedRating = newRating;
    } else if (selectedRating! == newRating) {
      selectedRating = null;
    } else {
      selectedRating = newRating;
    }
    notifyListeners();
  }

  RatingsContainer({Key? key}) : super(key: key);

  @override
  State<RatingsContainer> createState() => _RatingsContainerState();
}

class _RatingsContainerState extends State<RatingsContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // TEXT
        Text(
          'Your rating',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.star,
                    size: 24,
                  ),
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      widget.setRating(i);
                    });
                  },
                  color: widget.selectedRating != null &&
                          i <= widget.selectedRating!
                      ? Colors.orange
                      : Colors.grey.withOpacity(0.7),
                ),
              )
          ],
        ),
        // STARS
      ],
    );
  }
}
