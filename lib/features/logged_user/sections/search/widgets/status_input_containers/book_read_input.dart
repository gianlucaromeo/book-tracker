import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/books_status.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookReadInputContainer extends StatefulWidget {
  final GoogleBookModel bookData;
  const BookReadInputContainer({Key? key, required this.bookData})
      : super(key: key);

  @override
  State<BookReadInputContainer> createState() => _BookReadInputContainerState();
}

class _BookReadInputContainerState extends State<BookReadInputContainer> {
  int rating = -1;
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // DATE RANGE PICKER
          TextButton.icon(
            onPressed: () => pickDateRange(),
            icon: const Icon(Icons.date_range),
            label: const Text('Date Range'),
          ),
          if (dateRange != null)
            Text(
                'Difference in days: ${dateRange!.end.difference(dateRange!.start).inDays}'),
          // RATING STARS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                IconButton(
                  icon: rating >= i
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border_outlined),
                  onPressed: () => setState(() {
                    if (rating == i) {
                      rating = -1;
                    } else {
                      rating = i;
                    }
                  }),
                ),
            ],
          ),
          TransparentDivider.h(20.0),
          ElevatedButton.icon(
            onPressed: _onAddBook,
            icon: const Icon(Icons.add),
            label: const Text('Add Book!'),
          ),
          const Text(
            'Comments and saved pages can be added from your Library!',
          ),
        ],
      ),
    );
  }

  _onAddBook() {
    BookModel newBook = BookModel(
      bookData: widget.bookData,
      bookStatus: BookStatusRead(
        dateStart: dateRange?.start,
        dateEnd: dateRange?.end,
        rating: rating != -1 ? rating + 1 : null,
      ),
    );
    BooksRepository.addBook(newBook);
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (newDateRange == null) {
      return;
    }

    setState(() {
      dateRange = newDateRange;
    });
  }
}
