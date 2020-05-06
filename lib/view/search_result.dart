import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({this.title, this.searchDelegate});

  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title), onTap: () => searchDelegate.close(context, title));
  }
}
