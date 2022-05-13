import 'package:flutter/material.dart';

enum BookImageSize {
  bookFindTile,
  searchedBook,
  setBookStatus,
  trendingBook,
}

class BookImage extends StatelessWidget {
  final BookImageSize size;
  final String? imageUrl;
  static const noImageUrl =
      'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png';

  const BookImage({Key? key, required this.size, required this.imageUrl})
      : super(key: key);

  Size _getSize() {
    if (size == BookImageSize.bookFindTile) {
      return const Size(70, 100);
    } else if (size == BookImageSize.searchedBook) {
      return const Size(100, 160);
    } else if (size == BookImageSize.trendingBook) {
      return const Size(110, 190);
    } else {
      return const Size(80, 140);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = _getSize();
    const radius = 2.0;
    return Container(
      width: imageSize.width,
      height: imageSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            offset: const Offset(2, 5),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          imageUrl ?? noImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
