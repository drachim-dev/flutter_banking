import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/router.dart';
import 'package:intl/intl.dart';

class AmountSelectionView extends StatefulWidget {
  final Transaction transaction;

  const AmountSelectionView({Key key, @required this.transaction})
      : super(key: key);

  @override
  _AmountSelectionViewState createState() =>
      _AmountSelectionViewState(this.transaction);
}

class _AmountSelectionViewState extends State<AmountSelectionView>
    with SingleTickerProviderStateMixin {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'DE');

  AnimationController controller;
  Animation<double> offsetAnimation;
  final double offsetEnd = 24.0;

  int _cents = 0;

  final Transaction _transaction;

  _AmountSelectionViewState(this._transaction);

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    offsetAnimation = Tween(begin: 0.00, end: offsetEnd)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('To ${_transaction.foreignAccount.owner}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                    animation: offsetAnimation,
                    builder: (buildContext, child) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: offsetAnimation.value + offsetEnd,
                            right: offsetEnd - offsetAnimation.value),
                        child: Text(
                          formatCurrency.format(_cents.toDouble() / 100),
                          textAlign: TextAlign.center,
                          style:
                              theme.textTheme.display3.copyWith(fontSize: 48),
                        ),
                      );
                    }),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberRow(1, 3),
                _buildNumberRow(4, 3),
                _buildNumberRow(7, 3),
                _buildFunctionRow(),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
                child: Text('Continue'),
                onPressed: () {
                  _transaction.amount = _cents / 100;
                  Navigator.of(context).pushNamed(
                      Router.AccountSelectionViewRoute,
                      arguments: _transaction);
                })
          ]),
        ));
  }

  Row _buildNumberRow(int startNumber, int buttonsCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = startNumber; i < startNumber + buttonsCount; i++)
          _buildNumberButton('$i')
      ],
    );
  }

  Row _buildFunctionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNumberButton('00'),
        _buildNumberButton('0'),
        _buildBackspaceButton(),
      ],
    );
  }

  FlatButton _buildNumberButton(String numberString) {
    int number = int.parse(numberString);

    return FlatButton(
      padding: const EdgeInsets.all(Dimensions.numberButtonPadding),
      shape: CircleBorder(),
      child: Text('$numberString',
          textScaleFactor: Dimensions.numberTextScaleFactor),
      onPressed: () {
        _insertNumber(number);
        if (numberString == '00') _insertNumber(number);
      },
    );
  }

  FlatButton _buildBackspaceButton() {
    return FlatButton(
      padding: const EdgeInsets.all(Dimensions.numberButtonPadding),
      shape: CircleBorder(),
      child: Icon(Icons.backspace),
      onPressed: () => _removeNumber(),
    );
  }

  void _insertNumber(int number) {
    if (_cents >= 1000000 * 100) {
      controller.forward();
      return null;
    }

    setState(() {
      _cents = _cents * 10 + number;
    });
  }

  void _removeNumber() {
    setState(() {
      _cents = (_cents - _cents % 10) ~/ 10;
    });
  }
}
