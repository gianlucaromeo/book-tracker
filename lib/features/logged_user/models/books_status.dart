typedef Json = Map<String, dynamic>;

abstract class BookStatus {
  Json toJson();
}

class BookStatusNone extends BookStatus {
  @override
  Json toJson() => {
        "status": "none",
      };
}

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

  @override
  Json toJson() => {
        "status": "read",
        "dateStart": dateStart.toString(),
        "dateEnd": dateEnd.toString(),
        "rating": rating,
        "comments": comments,
        "savedPages": savedPages,
      };
}
