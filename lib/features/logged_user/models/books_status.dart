class BookStatus {}

class StatusNone extends BookStatus {}

class StatusRead extends BookStatus {
  DateTime? dateStart;
  DateTime? dateEnd; // only if dateStart != null
  int? rating; // 1 to 5
  List<String>? comments;
  List<int>? savedPages;
}
