abstract class BookStatus {}

class BookStatusNone extends BookStatus {}

class BookStatusRead extends BookStatus {
  DateTime? dateStart;
  DateTime? dateEnd;
  int? rating; // 1 to 5
  List<String>? comments;
  List<int>? savedPages;
  BookStatusRead({
    this.dateStart,
    this.dateEnd,
    this.rating,
    this.comments,
    this.savedPages,
  });
}
