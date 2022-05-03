import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BooksReadSection extends StatefulWidget {
  const BooksReadSection({Key? key}) : super(key: key);

  @override
  State<BooksReadSection> createState() => _ReadSectionState();
}

class _ReadSectionState extends State<BooksReadSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Read',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        TransparentDivider.h(20.0),
        StreamBuilder<QuerySnapshot>(
          stream: BooksRepository.booksReadStream(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: snap.data!.docs.map((bookToReadJson) {
                    BookModel bookModel =
                        BookModel.fromJson(bookToReadJson.data() as Json);
                    print('${bookModel.bookData.volumeInfo!.imageUrl}');
                    return SizedBox(
                      //height: 200,
                      width: 110,
                      child: Column(
                        children: [
                          BookImage(
                            imageUrl: bookModel.bookData.volumeInfo!.imageUrl,
                            size: BookImageSize.setBookStatus,
                          ),
                          TransparentDivider.h(10.0),
                          Text(
                            bookModel.bookData.volumeInfo!.title ??
                                'No Title', // '${googleBook.volumeInfo!.title}',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
