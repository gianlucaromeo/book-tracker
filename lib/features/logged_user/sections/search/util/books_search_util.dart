import 'package:http/http.dart' as http;

enum OrderByType { relevance, newest }

class BookSearchUtil {
  static Future<http.Response> findBooks(String bookToFind,
      {OrderByType orderByType = OrderByType.relevance}) {
    String orderBy =
        orderByType == OrderByType.relevance ? 'relevance' : 'newest';
    return http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$bookToFind&maxResults=8&orerBy=$orderBy')); // TODO
  }

  static Future<http.Response> findNRandomBooks({
    String bookToFind = 'il',
    int n = 4,
    OrderByType orderByType = OrderByType.relevance,
  }) {
    String orderBy =
        orderByType == OrderByType.relevance ? 'relevance' : 'newest';
    return http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$bookToFind&maxResults=$n&orerBy=$orderBy')); // TODO
  }
}
