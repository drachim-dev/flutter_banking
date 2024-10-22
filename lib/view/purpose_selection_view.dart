import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking/auto_router.gr.dart';

class PurposeSelectionView extends StatefulWidget {
  @override
  _PurposeSelectionViewState createState() => _PurposeSelectionViewState();
}

class _PurposeSelectionViewState extends State<PurposeSelectionView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Purpose'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextField(
                  style: theme.textTheme.headline4,
                  decoration: InputDecoration(
                    hintText: 'e.g. reference number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
                RaisedButton(
                    child: Text('Continue'),
                    onPressed: () => ExtendedNavigator.of(context)
                        .push(Routes.accountView))
              ]),
        ));
  }
}
