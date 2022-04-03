import 'dart:convert';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/google_book.dart';

class UserSectionSearch extends StatefulWidget {
  const UserSectionSearch({Key? key}) : super(key: key);

  @override
  _UserSectionSearchState createState() => _UserSectionSearchState();
}

class _UserSectionSearchState extends State<UserSectionSearch> {
  final _textController = TextEditingController();
  String _bookToFind = '';

  Future<http.Response> _findBooks() {
    return http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$_bookToFind&maxResults=8&orerBy=relevance')); // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSearchTextField(),
        TransparentDivider.h(30.0),
        _bookToFind.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Some text here.'),
              )
            : buildListOfBooks(),
      ],
    );
  }

  Expanded buildListOfBooks() {
    return Expanded(
      child: Center(
        child: Container(
          color: Colors.transparent,
          child: FutureBuilder(
              future: _findBooks(),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text(
                      'Please check your connection and try again',
                    );
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error.');
                    } else {
                      Map<String, dynamic> books =
                          jsonDecode(snapshot.data!.body);
                      if (books['items'] == null) {
                        return const Text('No Items');
                      } else {
                        return ListView.builder(
                          //padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemCount: books['items'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return BookFound(
                              book: GoogleBookModel.fromJSON(
                                  books['items'][index]),
                            );
                          },
                        );
                      }
                    }
                }
              }),
        ),
      ),
    );
  }

  TextField buildSearchTextField() {
    return TextField(
      controller: _textController,
      onChanged: (newText) {
        setState(() {
          _bookToFind = newText;
        });
      },
      decoration: InputDecoration(
        hintText: ' Search books',
        prefixIcon: const Icon(
          Icons.search,
          size: 27,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(13.0)),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.1), width: 4)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(13.0)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0)),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _textController.clear();
            setState(() {
              _bookToFind = '';
            });
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
