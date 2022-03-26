import 'dart:convert';

import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/book.dart';

class UserSectionSearch extends StatefulWidget {
  const UserSectionSearch({Key? key}) : super(key: key);

  @override
  _UserSectionSearchState createState() => _UserSectionSearchState();
}

class _UserSectionSearchState extends State<UserSectionSearch> {
  final double _padding = 20.0;

  final _textController = TextEditingController();
  String _bookToFind = '';

  Future<http.Response> _findBooks() {
    return http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$_bookToFind&maxResults=8')); // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(),
          TransparentDivider.h(30.0),
          _bookToFind.isEmpty
              ? _buildSuggestionsSection()
              : _buildListOfBooks(),
        ],
      ),
    );
  }

  Expanded _buildSuggestionsSection() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSuggestionsTitle(),
          TransparentDivider.h(30.0),
          _buildSuggestionsBooks(),
        ],
      ),
    );
  }

  Expanded _buildListOfBooks() {
    return Expanded(
      child: Center(
        child: Container(
          color: Colors.white,
          child: FutureBuilder(
              future: _findBooks(),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text('None');
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemCount: books['items'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return BookFound(
                              book: Book.fromJSON(books['items'][index], BookStatus.noStatus),
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

  SizedBox _buildSuggestionsBooks() {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < 7; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                height: 240,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Text _buildSuggestionsTitle() {
    return const Text(
      'Books for you',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      controller: _textController,
      onChanged: (newText) {
        setState(() {
          _bookToFind = newText;
        });
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: ' Search books',
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.withOpacity(0.7),
          size: 27,
        ),
        fillColor: Colors.white,
        hoverColor: Colors.white,
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
