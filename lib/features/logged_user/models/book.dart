enum BookStatus {
  noStatus, read, currentlyReading, toRead, startedButNeverFinished
}

class Book {

  late final String _title;
  late final String _description;
  late final String _author;
  late final int _pages;
  late final BookStatus _status;

  late final String _imgUrl;

  // TODO Add Ratings, Generes, ...

  Book(this._title, this._description, this._author, this._pages, this._status, this._imgUrl);

  Book.fromJSON(Map<String, dynamic> json, BookStatus status)
      : _title = json['volumeInfo']['title'] ?? 'No Title',
        _description = json['volumeInfo']['description'] ?? 'No Description',
        _author = json['volumeInfo']['authors'] != null ? json['volumeInfo']['authors'][0] : '',
        _pages = json['volumeInfo']['pageCount'] ?? 1,
        _status = status,
        _imgUrl = json['volumeInfo']['imageLinks'] != null ? json['volumeInfo']['imageLinks']['thumbnail'] : '';

  String get title => _title;
  String get author => _author;
  int get pages => _pages;
  BookStatus get status => _status;
  String get imgUrl => _imgUrl;
  String get description => _description;

}