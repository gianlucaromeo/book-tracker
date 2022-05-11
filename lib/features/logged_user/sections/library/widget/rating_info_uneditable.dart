import 'package:flutter/material.dart';

class RatingInfoUneditable extends StatefulWidget {
  int rating;
  RatingInfoUneditable({Key? key, required this.rating}) : super(key: key);

  @override
  State<RatingInfoUneditable> createState() => _RatingInfoUneditableState();
}

class _RatingInfoUneditableState extends State<RatingInfoUneditable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              SizedBox(
                width: 24,
                height: 24,
                child: Icon(
                  Icons.star,
                  size: 24,
                  color: i < widget.rating
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
