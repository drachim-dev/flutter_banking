import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/router.dart';
import 'package:flutter_banking/view/transparent_app_bar.dart';

class AddTransactionOverview extends StatefulWidget {
  final Transaction transaction;

  const AddTransactionOverview({Key key, @required this.transaction})
      : super(key: key);

  @override
  _AddTransactionOverviewState createState() =>
      _AddTransactionOverviewState(this.transaction);
}

class _AddTransactionOverviewState extends State<AddTransactionOverview>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<Offset> _slideInAnimation1;
  Animation<Offset> _slideInAnimation2;
  Animation<Offset> _slideInAnimation3;

  Animation<double> _fadeTransition1;
  Animation<double> _fadeTransition2;
  Animation<double> _fadeTransition3;

  bool _isRealtimeTransaction = false;
  bool _isSending = false;
  bool _isSuccess = false;

  final Transaction _transaction;

  _AddTransactionOverviewState(this._transaction);

  @override
  void initState() {
    super.initState();

    setupAnimations();
    _animationController.forward();
  }

  void setupAnimations() {
    final Duration _animationDuration = Duration(milliseconds: 1200);
    final Offset _positionOffset = Offset(-0.5, 0.0);

    _animationController =
        AnimationController(duration: _animationDuration, vsync: this);

    _slideInAnimation1 = Tween<Offset>(begin: _positionOffset, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.4, curve: Curves.fastOutSlowIn)));

    _fadeTransition1 = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.4, curve: Curves.fastOutSlowIn)));

    _slideInAnimation2 = Tween<Offset>(begin: _positionOffset, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.1, 0.6, curve: Curves.fastOutSlowIn)));

    _fadeTransition2 = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.1, 0.6, curve: Curves.fastOutSlowIn)));

    _slideInAnimation3 = Tween<Offset>(begin: _positionOffset, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.2, 0.8, curve: Curves.fastOutSlowIn)));

    _fadeTransition3 = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.2, 0.8, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle amountTextStyle =
        theme.textTheme.title.copyWith(color: Colors.white);
    final Color amountBgColor = MyColor.olbPrimary;

    const double contentPadding = 16.0;

    return Stack(children: [
      Scaffold(
          appBar: TransparentAppBar(
            title: Text('Validate and send'),
          ),
          body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeTransition(
                    opacity: _fadeTransition2,
                    child: SlideTransition(
                      position: _slideInAnimation2,
                      child: Card(
                        margin: const EdgeInsets.only(top: 8),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () {},
                              contentPadding: const EdgeInsets.only(
                                  left: contentPadding,
                                  right: contentPadding,
                                  bottom: contentPadding,
                                  top: contentPadding * 2.5),
                              leading: Icon(Icons.person),
                              title: Text(_transaction.foreignAccount.owner),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(_transaction
                                      .foreignAccount.institute.name),
                                  Text(Utils.getFormattedNumber(
                                      _transaction.foreignAccount.number)),
                                ],
                              ),
                            ),
                            Divider(),
                            ListTile(
                              onTap: () {},
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: contentPadding),
                              leading: Icon(Icons.add),
                              title: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Purpose of transaction'),
                              ),
                              // trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: FadeTransition(
                    opacity: _fadeTransition1,
                    child: SlideTransition(
                      position: _slideInAnimation1,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                            Utils.getFormattedCurrency(_transaction.amount),
                            style: amountTextStyle),
                        color: amountBgColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            FadeTransition(
              opacity: _fadeTransition3,
              child: SlideTransition(
                position: _slideInAnimation3,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: contentPadding),
                  leading: Icon(AccountTypeHelper.getIcon(
                      _transaction.ownAccount.accountType)),
                  title: Text(_transaction.ownAccount.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(AccountTypeHelper.getValue(
                          _transaction.ownAccount.accountType)),
                      Text(Utils.getFormattedNumber(
                          _transaction.ownAccount.number)),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                ),
              ),
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.access_time),
              title: Text('Realtime transaction'),
              initiallyExpanded: _isRealtimeTransaction,
              onExpansionChanged: _onExpansionChanged,
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: contentPadding),
                  leading: Icon(Icons.monetization_on),
                  title: Text('Transaction fees'),
                  trailing: Text('+0,50 €'),
                  onTap: () {},
                ),
              ],
              trailing: IgnorePointer(
                child: Switch(
                  onChanged: (_) {},
                  value: _isRealtimeTransaction,
                ),
              ),
            ),
          ])),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _isSending = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  _isSuccess = true;
                });
              });
            },
            child: Text('Transfer now'),
          ),
        ),
      ),
      if (_isSending || _isSuccess)
        Align(
          alignment: Alignment.center,
          child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.9),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_isSuccess ? 'Success' : 'Sending',
                                style: theme.textTheme.display1),
                            SizedBox(height: 36),
                            AnimatedCrossFade(
                              firstChild: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                              secondChild: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.check_circle,
                                    color: MyColor.olbPrimary, size: 48),
                              ),
                              duration: Duration(milliseconds: 500),
                              crossFadeState: _isSuccess
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                            ),
                          ],
                        ),
                      ),
                      if (_isSuccess)
                        Container(
                          color: MyColor.olbPrimary,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () =>
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Router.HomeViewRoute,
                                            (Route<dynamic> route) => false),
                                    child: Text(
                                      'OVERVIEW',
                                      style: theme.textTheme.body1
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                    indent: 6,
                                    endIndent: 6,
                                    color: MyColor.lighterGrey),
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              Router.HomeViewRoute,
                                              (Route<dynamic> route) => false);
                                      Navigator.of(context).pushNamed(
                                          Router.ContactSelectionViewRoute);
                                    },
                                    child: Text('SEND MORE',
                                        style: theme.textTheme.body1
                                            .copyWith(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ))),
        )
    ]);
  }

  _onExpansionChanged(bool value) {
    setState(() {
      _isRealtimeTransaction = value;
    });
  }
}
