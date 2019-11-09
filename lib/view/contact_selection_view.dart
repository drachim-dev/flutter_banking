import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/view/list_group_header.dart';
import 'package:flutter_banking/viewmodel/contact_model.dart';

class ContactSelectionView extends StatefulWidget {
  @override
  _ContactSelectionViewState createState() => _ContactSelectionViewState();
}

class _ContactSelectionViewState extends State<ContactSelectionView> {
  List<Account> _selectionList = [];
  List<Account> _suggestions = [];
  List<Account> _contacts = [];

  Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BaseView<ContactModel>(onModelReady: (model) async {
      _suggestions = await model.getSuggestions();
      _contacts = await model.getContacts();
      _selectionList.addAll(_suggestions);
      _selectionList.addAll(_contacts);
    }, builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Transfer money'),
          ),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.listItemPaddingHorizontal,
                        vertical: Dimensions.listItemPaddingVertical),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search',
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.listVerticalPadding),
                          itemBuilder: (context, index) {
                            var account = _selectionList[index];
                            var initials = account.owner.substring(0, 1) +
                                account.owner.split(' ').last.substring(0, 1);
                            var contactItem = ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.listItemPaddingHorizontal,
                                    vertical:
                                        Dimensions.listItemPaddingVertical),
                                leading: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    initials,
                                    style: theme.textTheme.body1.copyWith(
                                        fontSize: 16, color: MyColor.darkGrey),
                                  ),
                                  decoration: ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: MyColor.lightGrey),
                                ),
                                title: Text(account.owner),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(account.institute.name),
                                      Text(Utils.getFormattedNumber(account.number))
                                    ]),
                                onTap: () {
                                  // unfocus SearchTextField
                                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

                                  // create transaction
                                  _transaction = Transaction(foreignAccount: _selectionList[index]);

                                  // pass transaction to new route
                                  Navigator.of(context).pushNamed(
                                    Router.AmountSelectionViewRoute,
                                    arguments: _transaction);
                                });

                            if (index == 0) {
                              return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    ListTile(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal:
                                          Dimensions.listItemPaddingHorizontal,
                                          vertical: 4),
                                      leading: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: Icon(Icons.person_add),
                                      ),
                                      title: Text('Add new contact'),
                                      onTap: () => Navigator.of(context).pushNamed(Router.AddContactViewRoute),
                                    ),
                                    ListGroupHeader(
                                        context: context,
                                        leadingText: 'Suggestions'),
                                    contactItem
                                  ]);
                            }

                            return contactItem;
                          },
                          separatorBuilder: (context, index) {
                            // Contacts header
                            if (index == _suggestions.length - 1) {
                              return ListGroupHeader(
                                  context: context, leadingText: 'Contacts');
                            }

                            // Divider
                            return Divider();
                          },
                          itemCount: _selectionList.length))
                ]));
    });
  }
}
