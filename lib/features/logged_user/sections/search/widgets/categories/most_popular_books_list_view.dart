import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/repository/ibs_to_books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/searched_book_page.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/util/custom_page_route.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MostPopularBooksListView extends StatelessWidget {
  const MostPopularBooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.searchPagePopularBooksSectionTitle,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        TransparentDivider.h(20.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<QuerySnapshot>(
            stream: IBSToBooksRepository
                .mostGiftedBooks(), // BooksRepository.globalPopularBooks(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
              if (snap.hasData) {
                return Row(
                  children: snap.data!.docs.map((bookToReadJson) {
                    GoogleBookModel bookModel =
                        GoogleBookModel.fromJson(bookToReadJson.data() as Json);
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        CustomPageRoute(
                          child: SearchedBookPage(
                              googleBookModel: bookModel, updateStatus: false),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.defaultPadding / 2),
                        child: SizedBox(
                          //height: 230.0,
                          width: 120,
                          child: Column(
                            children: [
                              BookImage(
                                imageUrl:
                                    bookModel.volumeInfo!.imageLinks!.thumbnail,
                                size: BookImageSize.trendingBook,
                              ),
                              TransparentDivider.h(10.0),
                              Text(
                                bookModel.volumeInfo!.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
