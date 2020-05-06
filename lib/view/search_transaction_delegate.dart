import 'package:flutter/material.dart';
import 'package:flutter_banking/view/search_result.dart';
import 'package:flutter_banking/view/search_suggestion_list.dart';

class SearchTransactionDelegate extends SearchDelegate<String> {
  final List<String> _data = [
    'Achim',
    'Helmut',
    'Heinz',
    'Herbert',
    'Heinrich',
    'Manni'
  ];
  final List<String> _history = ['Achim', 'Heinrich'];

  // TODO: SearchDelegate doesn't respect theme
  // Workaround from https://github.com/flutter/flutter/issues/32180
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isNotEmpty
        ? [
            IconButton(
              tooltip: 'Clear',
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          ]
        : null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> items =
        query.isEmpty ? _history : _data.where((String s) => s.contains(query));

    final List<Suggestion> suggestions = items.map((e) {
      return Suggestion(name: e);
    }).toList();

    return SearchSuggestionListView(
      query: query,
      items: suggestions.toList(),
      onTap: (suggestion) {
        query = suggestion.name;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text(
          'Search term must be longer than two letters.',
        ),
      );
    }

    if (!_data.contains(query)) {
      return Center(
        child: Text(
          'No result',
        ),
      );
    }

    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return SearchResult(
            title: _data[index],
            searchDelegate: this,
          );
        });
  }
}
