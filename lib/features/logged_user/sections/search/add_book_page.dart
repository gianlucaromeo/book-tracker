import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/set_status_button.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/set_status_input_containers/book_read_input.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  final GoogleBookModel googleBookModel;
  const AddBookPage({Key? key, required this.googleBookModel})
      : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildImageContainer(),
            TransparentDivider.h(20.0),
            buildBookTitle(),
            TransparentDivider.h(6.0),
            buildBookAuthors(),
            TransparentDivider.h(20.0),
            buildButtonsListView(),
            TransparentDivider.h(20.0),
            BookReadInputContainer(bookData: widget.googleBookModel),
          ],
        ),
      ),
    );
  }

  buildButtonsListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < 6; ++i) const SetStatusButton(),
        ],
      ),
    );
  }

  Text buildBookAuthors() {
    return Text(
      widget.googleBookModel.volumeInfo?.authors?.toString() ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text buildBookTitle() {
    return Text(
      widget.googleBookModel.volumeInfo?.title ?? 'No title',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    );
  }

  Container buildImageContainer() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Image.network(
        widget.googleBookModel.volumeInfo?.imageUrl ??
            'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
        width: 70,
        height: 100,
      ),
    );
  }
}
