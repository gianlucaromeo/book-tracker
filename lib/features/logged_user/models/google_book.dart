class GoogleBookModel {
  /// Book id for Google Books API.
  /// Useful to fetch more information if required.
  late final String? id;

  // VOLUME INFO
  late final String? title;
  late final List<String>? authors;
  late final String? publisher;
  late final DateTime? publishedDate;
  late final int? pageCount;
  late final String? description;
  late final List<String>? categories;
  late final num? averageRating; // 1.0 to 5.0
  late final int? ratingsCount;
  late final String? imageUrl; // ~ 128px
  late final String? language; // ISO 639-1 'fr', 'en', ...
  late final String? mainCategory; // ! Always null (?)

  GoogleBookModel();

  GoogleBookModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];

    final info = json['volumeInfo'];

    title = info['title'];

    final authorsData = info['authors'];
    if (authorsData != null) {
      authors = List<String>.from(authorsData);
    } else {
      authors = List<String>.empty();
    }

    publisher = info['publisher'];

    final publishDateData = info['publishedDate'];
    if (publishDateData != null) {
      publishedDate = DateTime.tryParse(publishDateData);
    } else {
      publishedDate = null;
    }

    pageCount = info['pageCount'];
    description = info['description'];

    final categoriesData = info['categories'];
    if (categoriesData != null) {
      categories = List<String>.from(categoriesData);
    } else {
      categories = List<String>.empty();
    }

    averageRating = info['averageRating'];

    ratingsCount = info['ratingsCount'];

    final imageLinksData = info['imageLinks'];
    if (imageLinksData != null) {
      imageUrl = imageLinksData['thumbnail'];
    } else {
      imageUrl = null;
    }

    language = info['language'];
    mainCategory = info['mainCategory'];
  }

  @override
  String toString() {
    String info1 =
        'id: $id\nTitle: $title\nAuthors: ${authors.toString()}\nPublisher: $publisher';
    String info2 = '\nPublished Date: $publishedDate\nPage Count: $pageCount\n';
    String info3 =
        '\nDescription: $description\nCategories: ${categories.toString()}\nAverage rating: $averageRating';
    String info4 =
        '\nRatings count: $ratingsCount\nImage url: $imageUrl\nLanguage: $language\nMain category: $mainCategory';
    return 'INFO\n$info1'; // $info2 $info3 $info4';
  }

  Map<String, dynamic> toJson() {
    return {'info': toString()};
  }
}
