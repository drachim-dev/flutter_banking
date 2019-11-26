import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/viewmodel/account_model.dart';

class AccountView extends StatefulWidget {
  final Transaction transaction;

  const AccountView({Key key, this.transaction}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState(this.transaction);
}

class _AccountViewState extends State<AccountView> {
  final Transaction _transaction;

  _AccountViewState(this._transaction);

  @override
  Widget build(BuildContext context) {
    bool selectionMode = _transaction != null;

    return BaseView<AccountModel>(builder: (_, model, child) {
      return Scaffold(
          appBar: _buildAppBar(selectionMode),
          body: _buildBody(model, selectionMode));
    });
  }

  AppBar _buildAppBar(bool selectionMode) {
    return AppBar(
      title: Text(selectionMode ? 'Select account for payment' : 'Accounts'),
      actions: [
        if (!selectionMode)
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
      ],
    );
  }

  Widget _buildBody(AccountModel model, bool selectionMode) {
    switch (model.state) {
      case ViewState.NoDataAvailable:
        return _buildNoDataUi();
      case ViewState.Error:
        return _buildErrorUi();
      case ViewState.DataFetched:
        return _buildAccountListView(model.accounts, selectionMode);
      case ViewState.Busy:
      default:
        return _buildLoadingUi();
    }
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

  ListView _buildAccountListView(List<Account> accounts, bool selectionMode) {
    return ListView.separated(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.listVerticalPadding),
      itemCount: accounts.length,
      itemBuilder: (_, index) {
        var account = accounts[index];

        return _buildAccountItem(selectionMode, account);
      },
      separatorBuilder: (_, index) {
        return Divider();
      },
    );
  }

  ListTile _buildAccountItem(bool selectionMode, Account account) {
    return ListTile(
      onTap: () => _onTapAccount(selectionMode, account),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimensions.listItemPaddingHorizontal,
          vertical: Dimensions.listItemPaddingVertical),
      leading: Icon(AccountTypeHelper.getIcon(account.accountType)),
      trailing: Text(Utils.getFormattedCurrency(account.balance)),
      title: Text(account.name),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(account.institute.name),
        Text(Utils.getFormattedNumber(account.number))
      ]),
    );
  }

  void _onTapAccount(bool selectionMode, Account account) {
    if (selectionMode) {
      _transaction.ownAccount = account;
      Navigator.of(context).pushNamed(Router.AddTransactionOverviewRoute,
          arguments: _transaction);
    }
  }
}
