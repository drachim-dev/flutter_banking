import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
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
  bool _selectionMode = false;

  _AccountViewState(this._transaction);

  @override
  void initState() {
    super.initState();

    _selectionMode = _transaction != null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountModel>(builder: (_, model, child) {
      return Scaffold(appBar: _buildAppBar(), body: _buildBody(model));
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_selectionMode ? 'Select account for payment' : 'Accounts'),
      actions: [
        if (!_selectionMode)
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(Router.addAccountView),
            icon: Icon(Icons.add),
          )
      ],
    );
  }

  Widget _buildBody(AccountModel model) {
    switch (model.state) {
      case ViewState.NoDataAvailable:
        return _buildNoDataUi();
      case ViewState.Error:
        return _buildErrorUi();
      case ViewState.DataFetched:
        return _buildAccountListView(model.accounts);
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

  ListView _buildAccountListView(List<Account> accounts) {
    return ListView.separated(
      padding:
          const EdgeInsets.symmetric(vertical: Dimens.listVerticalPadding),
      itemCount: accounts.length,
      itemBuilder: (_, index) => _buildAccountItem(accounts[index]),
      separatorBuilder: (_, index) => Divider(),
    );
  }

  ListTile _buildAccountItem(Account account) {
    return ListTile(
      onTap: () => _onTapAccount(account),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.listItemPaddingHorizontal,
          vertical: Dimens.listItemPaddingVertical),
      leading: Icon(AccountTypeHelper.getIcon(account.accountType)),
      trailing: Text(Utils.getFormattedCurrency(account.balance)),
      title: Text(account.name),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(account.institute.name),
        Text(Utils.getFormattedNumber(account.number))
      ]),
    );
  }

  void _onTapAccount(Account account) {
    if (_selectionMode) {
      _transaction.ownAccount = account;
      Navigator.of(context).pushNamed(Router.addTransactionOverview,
          arguments: _transaction);
    }
  }
}
