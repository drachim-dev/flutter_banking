import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/purpose.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/view/list_group_header.dart';
import 'package:flutter_banking/view/search_transaction_delegate.dart';
import 'package:flutter_banking/viewmodel/spending_model.dart';

class SpendingView extends StatefulWidget {
  @override
  _SpendingViewState createState() => _SpendingViewState();
}

class _SpendingViewState extends State<SpendingView> {
  final SearchTransactionDelegate _delegate = SearchTransactionDelegate();

  String _lastStringSelected;

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
            tooltip: 'Filter',
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ]);
  }

  void _onTapActionSearch() async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: _delegate,
    );
    if (selected != null && selected != _lastStringSelected) {
      setState(() => _lastStringSelected = selected);
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
      padding: const EdgeInsets.only(bottom: Dimens.listVerticalPadding),
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
            horizontal: Dimens.listItemPaddingHorizontal,
            vertical: Dimens.listItemPaddingVertical),
        leading:
            Icon(AccountTypeHelper.getIcon(transaction.ownAccount.accountType)),
        title: Text(transaction.foreignAccount.customer),
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
                  trailingText: 'Daily balance')
              : Divider(),
          transactionItem
        ]);
  }
}
