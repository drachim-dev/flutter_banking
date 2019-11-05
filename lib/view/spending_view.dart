import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/purpose.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/view/list_group_header.dart';
import 'package:flutter_banking/viewmodel/spending_model.dart';
import 'package:provider/provider.dart';

class SpendingView extends StatefulWidget {
  @override
  _SpendingViewState createState() => _SpendingViewState();
}

class _SpendingViewState extends State<SpendingView> {
  final _SearchDemoSearchDelegate _delegate = _SearchDemoSearchDelegate();

  int _lastIntegerSelected;

  @override
  Widget build(BuildContext context) {
    return BaseView<SpendingModel>(onModelReady: (model) async {
      await model.getAccounts(Provider.of<User>(context).id);
      model.getTransactions(model.accounts.first.number);
    }, builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Spending'),
              actions: [
                IconButton(
                  tooltip: 'Search',
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final int selected = await showSearch<int>(
                      context: context,
                      delegate: _delegate,
                    );
                    if (selected != null && selected != _lastIntegerSelected) {
                      setState(() {
                        _lastIntegerSelected = selected;
                      });
                    }
                  },
                ),
                IconButton(
                  tooltip: 'More',
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ]),
          body: model.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: Dimensions.listVerticalPadding),
                  itemCount: model.transactions.length,
                  itemBuilder: (context, index) {
                    Transaction item = model.transactions[index];
                    var transactionItem = ListTile(
                        onTap: () => {},
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.listItemPaddingHorizontal,
                            vertical: Dimensions.listItemPaddingVertical),
                        leading: Icon(AccountTypeHelper.getIcon(
                            item.ownAccount.accountType)),
                        title: Text(item.foreignAccount.owner),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.usageText),
                              Text(PurposeHelper.getValue(item.purpose))
                            ]),
                        trailing:
                            Text(Utils.getFormattedCurrency(item.amount)));

                    // group items by date
                    var isNewGroup = index == 0 ||
                        item.date != model.transactions[index - 1].date;

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          isNewGroup
                              ? ListGroupHeader(
                                  context: context,
                                  leadingText:
                                      Utils.getFormattedDate(item.date),
                                  trailingText: 'Tagessaldo')
                              : Divider(),
                          transactionItem
                        ]);
                  }));
    });
  }
}

class _SearchDemoSearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[42607, 85604, 66374, 44, 174];

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<int> suggestions = query.isEmpty
        ? _history
        : _data.where((int i) => '$i'.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.map((int i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
        _ResultCard(
          title: 'Next integer',
          integer: searched + 1,
          searchDelegate: this,
        ),
        _ResultCard(
          title: 'Previous integer',
          integer: searched - 1,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty
        ? null
        : <Widget>[
            IconButton(
              tooltip: 'Clear',
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final int integer;
  final String title;
  final SearchDelegate<int> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$integer',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
