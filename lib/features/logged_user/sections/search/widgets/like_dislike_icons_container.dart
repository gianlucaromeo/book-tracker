import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class LikeDislikeIconsContainer extends StatefulWidget with ChangeNotifier {
  bool? like;

  setLike(bool? like) {
    this.like = like;
    notifyListeners();
  }

  LikeDislikeIconsContainer({Key? key}) : super(key: key);

  @override
  State<LikeDislikeIconsContainer> createState() =>
      _LikeDislikeIconsContainerState();
}

class _LikeDislikeIconsContainerState extends State<LikeDislikeIconsContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildLikeIcon(),
        TransparentDivider.w(25.0),
        buildDislikeIcon(),
      ],
    );
  }

  buildLikeIcon() {
    return IconButton(
      icon: Icon(
        Icons.thumb_up_alt_outlined,
        color: widget.like == null
            ? themeController.isDarkTheme
                ? Colors.grey
                : Colors.black
            : widget.like!
                ? Colors.green.withOpacity(0.6)
                : Colors.grey,
        size: 50.0,
      ),
      onPressed: () => setState(() {
        bool? like = widget.like;
        if (like == null) {
          like = true;
        } else {
          if (like == false) {
            like = true;
          } else {
            like = null;
          }
        }
        widget.setLike(like);
      }),
    );
  }

  buildDislikeIcon() {
    return IconButton(
      icon: Icon(
        Icons.thumb_down_alt_outlined,
        color: widget.like == null
            ? themeController.isDarkTheme
                ? Colors.grey
                : Colors.black
            : widget.like!
                ? Colors.grey
                : Colors.red.withOpacity(0.6),
        size: 50.0,
      ),
      onPressed: () => setState(() {
        bool? like = widget.like;
        if (like == null) {
          like = false;
        } else {
          if (like == true) {
            like = false;
          } else {
            like = null;
          }
        }
        widget.setLike(like);
      }),
    );
  }
}
