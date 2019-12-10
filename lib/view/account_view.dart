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
  AccountModel _model;

  _AccountViewState(this._transaction);

  Offset _tapPosition;

  @override
  void initState() {
    super.initState();

    _selectionMode = _transaction != null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountModel>(builder: (_, model, child) {
      this._model = model;
      return Scaffold(appBar: _buildAppBar(), body: _buildBody());
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
                tooltip: 'Add account',
            icon: Icon(Icons.add),
          )
      ],
    );
  }

  Widget _buildBody() {
    switch (_model.state) {
      case ViewState.NoDataAvailable:
        return _buildNoDataUi();
      case ViewState.Error:
        return _buildErrorUi();
      case ViewState.DataFetched:
        return _buildAccountListView();
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

  ListView _buildAccountListView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Dimens.listVerticalPadding),
      itemCount: _model.accounts.length,
      itemBuilder: (_, index) => _buildAccountItem(_model.accounts[index]),
      separatorBuilder: (_, index) => Divider(),
    );
  }

  GestureDetector _buildAccountItem(Account account) {
    return GestureDetector(
      onTapDown: _storePosition,
      child: ListTile(
        onTap: () => _onTapAccount(account),
        onLongPress: () => _onLongPressAccount(account),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimens.listItemPaddingHorizontal,
            vertical: Dimens.listItemPaddingVertical),
        leading: Icon(AccountTypeHelper.getIcon(account.accountType)),
        trailing: Text(Utils.getFormattedCurrency(account.balance)),
        title: Text(account.name),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account.institute.name),
              Text(Utils.getFormattedNumber(account.number))
            ]),
      ),
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _onTapAccount(Account account) {
    if (_selectionMode) {
      _transaction.ownAccount = account;
      Navigator.of(context)
          .pushNamed(Router.addTransactionOverview, arguments: _transaction);
    }
  }

  void _onLongPressAccount(Account account) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    var popup = showMenu(
      context: context,
      items: [
        'Edit',
        'Delete',
      ]
          .map((value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
    );

    popup.then((value) {
      switch (value) {
        case 'Edit':
          // TODO: Implement edit account
          // should share same view as addAccount but other title
          print('edit account');
          break;
        case 'Delete':
          _model.deleteAccount(account);
          break;
        default:
          break;
      }
    });
  }
}
