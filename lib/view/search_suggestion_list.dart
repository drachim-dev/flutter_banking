import 'package:flutter/material.dart';

class SearchSuggestionListView extends StatelessWidget {
  const SearchSuggestionListView({this.items, this.query, this.onTap});

  final List<Suggestion> items;
  final String query;
  final ValueChanged<Suggestion> onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyle = theme.textTheme.subtitle1;
    final TextStyle hitTextStyle =
        textStyle.copyWith(fontWeight: FontWeight.bold);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final Suggestion suggestion = items[index];
        final String name = suggestion.name;

        int firstHit = name.toUpperCase().indexOf(query.toUpperCase());
        if (firstHit == -1) {
          firstHit = 0;
        }

        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: name.substring(0, firstHit),
                  style: textStyle,
                ),
                TextSpan(
                  text: name.substring(firstHit, firstHit + query.length),
                  style: hitTextStyle,
                ),
                TextSpan(
                  text: name.substring(firstHit + query.length),
                  style: textStyle,
                ),
              ],
            ),
          ),
          onTap: () => onTap(suggestion),
        );
      },
    );
  }
}

class Suggestion {
  final id;
  final String name;

  Suggestion({this.id, this.name});
}
