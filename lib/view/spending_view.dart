import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/purpose.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/view/list_group_header.dart';
import 'package:flutter_banking/viewmodel/spending_model.dart';

class SpendingView extends StatefulWidget {
  @override
  _SpendingViewState createState() => _SpendingViewState();
}

class _SpendingViewState extends State<SpendingView> {
  final _SearchDemoSearchDelegate _delegate = _SearchDemoSearchDelegate();

  int _lastIntegerSelected;

  @override
  Widget build(BuildContext context) {
    return BaseView<SpendingModel>(builder: (_, model, child) {
      return Scaffold(appBar: _buildAppBar(), body: _buildBody(model));
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Text('Spending'),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.search),
            onPressed: _onTapActionSearch,
          ),
          IconButton(
            tooltip: 'More',
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ]);
  }

  void _onTapActionSearch() async {
    final int selected = await showSearch<int>(
      context: context,
      delegate: _delegate,
    );
    if (selected != null && selected != _lastIntegerSelected) {
      setState(() {
        _lastIntegerSelected = selected;
      });
    }
  }

  Widget _buildBody(SpendingModel model) {
    if (model.state == ViewState.NoDataAvailable) return _buildNoDataUi();
    if (model.state == ViewState.Error) return _buildErrorUi();
    if (model.state == ViewState.DataFetched)
      return _buildTransactionListView(model, model.transactions);

    return _buildLoadingUi();
  }

  Center _buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildNoDataUi() {
    return Center(child: Text('No data available'));
  }

  Center _buildErrorUi() {
    return Center(child: Text('An error occurred'));
  }

  ListView _buildTransactionListView(
      SpendingModel model, List<Transaction> transactions) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: Dimensions.listVerticalPadding),
      itemCount: transactions.length,
      itemBuilder: (_, index) =>
          _buildTransactionItem(model, transactions, index),
    );
  }

  Column _buildTransactionItem(
      SpendingModel model, List<Transaction> transactions, int index) {
    var transaction = transactions[index];
    var transactionItem = ListTile(
        onTap: () => {},
        contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimensions.listItemPaddingHorizontal,
            vertical: Dimensions.listItemPaddingVertical),
        leading:
            Icon(AccountTypeHelper.getIcon(transaction.ownAccount.accountType)),
        title: Text(transaction.foreignAccount.owner),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(transaction.usageText),
              Text(PurposeHelper.getValue(transaction.purpose))
            ]),
        trailing: Text(Utils.getFormattedCurrency(transaction.amount)));

    // group items by date
    var isNewGroup =
        index == 0 || transaction.date != transactions[index - 1].date;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          isNewGroup
              ? ListGroupHeader(
                  context: context,
                  leadingText: Utils.getFormattedDate(transaction.date),
                  trailingText: 'Tagessaldo')
              : Divider(),
          transactionItem
        ]);
  }
}

class _SearchDemoSearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[42607, 85604, 66374, 44, 174];

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
