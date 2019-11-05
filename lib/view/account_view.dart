import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/viewmodel/account_model.dart';
import 'package:provider/provider.dart';

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

    return BaseView<AccountModel>(
        onModelReady: (model) =>
            model.getAccounts(Provider.of<User>(context).id),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(selectionMode
                    ? 'Select account for payment'
                    : 'Accounts'),
                actions: [
                  if (!selectionMode)
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    )
                ],
              ),
              body: model.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.listVerticalPadding),
                      itemBuilder: (context, index) {
                        var item = model.accounts[index];
                        return ListTile(
                          onTap: () {
                            if (selectionMode) {
                              _transaction.ownAccount = item;

                              Navigator.of(context).pushNamed(
                                  Router.AddTransactionOverviewRoute,
                                  arguments: _transaction);
                            }
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.listItemPaddingHorizontal,
                              vertical: Dimensions.listItemPaddingVertical),
                          leading:
                              Icon(AccountTypeHelper.getIcon(item.accountType)),
                          trailing:
                              Text(Utils.getFormattedCurrency(item.balance)),
                          title: Text(item.name),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.institute.name),
                                Text(Utils.getFormattedNumber(item.number))
                              ]),
                        );
                      },
                      separatorBuilder: (builder, index) {
                        return Divider();
                      },
                      itemCount: model.accounts.length));
        });
  }
}
