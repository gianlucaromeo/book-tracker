import 'package:book_tracker/model/book.dart';
import 'package:flutter/material.dart';

class BookFound extends StatefulWidget {
  late final Book _book;

  BookFound({Key? key, required Book book}) : super(key: key) {
    _book = book;
  }

  @override
  _BookFoundState createState() => _BookFoundState();
}

class _BookFoundState extends State<BookFound> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      width: double.infinity,
      //height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [

            // -- Book Image
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ]
              ),
              child: Image.network(
                widget._book.imgUrl != ''
                    ? widget._book.imgUrl
                    : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
                width: 70,
                height: 100,
              ),
            ),

            // -- Title and Author
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget._book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      widget._book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // -- Action Button
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            )

          ],
        ),
      ),
    );
  }
}
