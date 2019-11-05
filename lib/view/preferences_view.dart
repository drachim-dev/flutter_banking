import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';

class PreferencesView extends StatefulWidget {
  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {

  bool _notifyOnTransaction = true;
  bool _notifyOnDocument = false;

  int _theme = 1;

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Settings'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.listVerticalPadding),
          children: <Widget>[
            _buildGroup(context, 'Allgemein'),
            ListTile(
                title: Text('Design'),
                subtitle: Text('White'),
                leading: Icon(Icons.color_lens),
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) => AlertDialog(
                            title: Text('Choose Design'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RadioListTile(
                                  title: Text('White'),
                                  groupValue: _theme,
                                  value: 1,
                                  onChanged: (value) {
                                    setState(() {
                                      _theme = value;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text('Dark'),
                                  groupValue: _theme,
                                  value: 2,
                                  onChanged: (value) {
                                    setState(() {
                                      _theme = value;
                                    });
                                  },
                                ),
                              ],
                            )),
                      ));
                }),
            _buildGroup(context, 'Benachrichtungen'),
            SwitchListTile(
                title: Text('Kontomelder'),
                secondary: Icon(Icons.monetization_on),
                value: _notifyOnTransaction,
                onChanged: (bool value) {
                  setState(() {
                    _notifyOnTransaction = value;
                  });
                }),
            SwitchListTile(
                title: Text('Postbox'),
                secondary: Icon(Icons.mail),
                value: _notifyOnDocument,
                onChanged: (bool value) {
                  setState(() {
                    _notifyOnDocument = value;
                  });
                }),
            _buildGroup(context, 'Service'),
            ListTile(
              title: Text('Adressänderung'),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text('Karte sperren'),
              leading: Icon(Icons.lock),
              onTap: () {},
            )
          ],
        ));
  }

  Widget _buildGroup(BuildContext context, String label) {
    final labelStyle =
    Theme.of(context).textTheme.subtitle.copyWith(color: Colors.grey);
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 16, bottom: 8),
      child: Text(
        label,
        style: labelStyle,
      ),
    );
  }
}