import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/view/list_group_header.dart';
import 'package:flutter_banking/viewmodel/contact_model.dart';

class ContactSelectionView extends StatefulWidget {
  @override
  _ContactSelectionViewState createState() => _ContactSelectionViewState();
}

class _ContactSelectionViewState extends State<ContactSelectionView> {
  final TextEditingController _searchController = TextEditingController();

  ContactModel _model;

  List<Account> _contactList;
  List<Account> _contacts;
  List<Account> _suggestions;

  Transaction _transaction;

  bool _showSearchResults = false;

  @override
  initState() {
    super.initState();
    _searchController.addListener(_onChangedSearchListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onChangedSearchListener() {
    _showSearchResults = _searchController.text.length >= 3;
    setState(() {
      _initContactList();
    });
  }

  void _initContactList() {
    if (_showSearchResults) {
      _contactList = _model.findContactsByName(_searchController.text);
    } else {
      _contacts ??= _model.allContacts;
      _suggestions ??= _model.suggestedContacts;
      _contactList = List.from(_contacts)..addAll(_suggestions);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BaseView<ContactModel>(builder: (_, model, child) {
      this._model = model;
      return Scaffold(appBar: _buildAppBar(), body: _buildBody(theme));
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Transfer money'),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_model.state == ViewState.Error) return _buildErrorUi();

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.listItemPaddingHorizontal,
            vertical: Dimensions.listItemPaddingVertical),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search',
          ),
        ),
      ),
      Expanded(
          child: ListView(children: [
        _buildAddContactItem(),
        if (_model.state == ViewState.DataFetched) _buildContactListView(theme),
        if (_model.state == ViewState.Busy) _buildLoadingUi(),
      ])),
    ]);
  }

  Center _buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildErrorUi() {
    return Center(child: Text('An error occurred'));
  }

  ListView _buildContactListView(ThemeData theme) {
    _initContactList();

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.listVerticalPadding),
      itemCount: _contactList.length,
      itemBuilder: (_, index) => _buildContactItem(theme, _contactList, index),
      separatorBuilder: (context, index) {
        // Contacts header
        if (index == _suggestions.length - 1) {
          return ListGroupHeader(context: context, leadingText: 'Contacts');
        }

        // Divider
        return Divider();
      },
    );
  }

  _buildContactItem(ThemeData theme, List<Account> contacts, int index) {
    var account = contacts[index];

    var initials = account.customer.substring(0, 1) +
        account.customer.split(' ').last.substring(0, 1);
    var contactItem = ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimensions.listItemPaddingHorizontal,
            vertical: Dimensions.listItemPaddingVertical),
        leading: Container(
          width: 48,
          height: 48,
          child: Center(
            child: Text(
              initials,
              style: theme.textTheme.body1
                  .copyWith(fontSize: 16, color: MyColor.darkGrey),
            ),
          ),
          decoration:
              ShapeDecoration(shape: CircleBorder(), color: MyColor.lightGrey),
        ),
        title: Text(account.customer),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(account.institute.name),
              Text(Utils.getFormattedNumber(account.number))
            ]),
        onTap: () {
          // unfocus SearchTextField
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

          // create transaction
          _transaction = Transaction(foreignAccount: account);

          // pass transaction to new route
          Navigator.of(context).pushNamed(Router.AmountSelectionViewRoute,
              arguments: _transaction);
        });

    if (index == 0) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ListGroupHeader(context: context, leadingText: _showSearchResults ? 'Results' : 'Suggestions'),
        contactItem
      ]);
    }

    return contactItem;
  }

  ListTile _buildAddContactItem() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimensions.listItemPaddingHorizontal, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(Icons.person_add),
      ),
      title: Text('Add new contact'),
      onTap: () => Navigator.of(context).pushNamed(Router.AddContactViewRoute),
    );
  }
}
