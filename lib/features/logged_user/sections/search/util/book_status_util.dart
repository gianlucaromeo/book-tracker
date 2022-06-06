import 'package:book_tracker/features/logged_user/models/book_status/book_status.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_type.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/status_currently_reading_form.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/status_read_form.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/status_to_read_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookStatusUtil {
  /// List of all the BookStatusTypes
  static const bookStatusTypes = BookStatusType.values;

  /// Bind BookStatusType to an index, in order to follow an order
  static const bookStatusIndexes = {
    BookStatusType.read: 0,
    BookStatusType.currentlyReading: 1,
    BookStatusType.toRead: 2,
  };

  /// Bind BookStatusType to an IconData
  static const bookStatusIcons = {
    BookStatusType.read: Icons.done_outline_rounded,
    BookStatusType.currentlyReading: Icons.timelapse_outlined,
    BookStatusType.toRead: Icons.calendar_today_outlined,
  };

  /// Bind BookStatusType to its Form
  static get bookStatusForms => {
        BookStatusType.read: BookStatusReadForm(
          bookStatus: BookStatusRead(),
        ),
        BookStatusType.currentlyReading: BookStatusCurrentlyReadingForm(
          bookStatus: BookStatusCurrentlyReading(),
        ),
        BookStatusType.toRead: BookStatusToReadForm(
          bookStatus: BookStatusToRead(),
        ),
      };

  /// Bind BookStatusType to its BookStatus
  static final bookStatusFromType = {
    BookStatusType.read: BookStatusRead(),
    BookStatusType.currentlyReading: BookStatusCurrentlyReading(),
    BookStatusType.toRead: BookStatusToRead(),
  };

  /// Bind BookStatusType to a String
  static Map<BookStatusType, String> getBookStatusTexts(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return {
      BookStatusType.read: l10n.readBooksStatusTitle,
      BookStatusType.currentlyReading: l10n.currentlyReadingBooksStatusTitle,
      BookStatusType.toRead: l10n.toReadBooksStatusTitle,
    };
  }

  static int getIndex(BookStatus bookStatus) {
    if (bookStatus is BookStatusRead) {
      return bookStatusIndexes[BookStatusType.read]!;
    } else if (bookStatus is BookStatusCurrentlyReading) {
      return bookStatusIndexes[BookStatusType.currentlyReading]!;
    }
    return bookStatusIndexes[BookStatusType.toRead]!;
  }

  static getBookStatusFromForm(Widget form) {
    if (form is BookStatusReadForm) {
      return form.getBookStatus();
    } else if (form is BookStatusToReadForm) {
      return form.getBookStatus();
    } else if (form is BookStatusCurrentlyReadingForm) {
      return form.getBookStatus();
    }
    return BookStatus();
  }

  static getStatusTypeNameFromStatus(BookStatus bookStatus) {
    if (bookStatus is BookStatusToRead) {
      return BookStatusType.toRead.name;
    } else if (bookStatus is BookStatusCurrentlyReading) {
      return BookStatusType.currentlyReading.name;
    } else if (bookStatus is BookStatusRead) {
      return BookStatusType.read.name;
    }
    return 'books'; // default collection name
  }

  static bookStatusFormFromStatus(BookStatus bookStatus) {
    if (bookStatus is BookStatusRead) {
      return BookStatusReadForm(bookStatus: bookStatus);
    } else if (bookStatus is BookStatusCurrentlyReading) {
      return BookStatusCurrentlyReadingForm(bookStatus: bookStatus);
    }
    return BookStatusToReadForm(bookStatus: bookStatus as BookStatusToRead);
  }
}
