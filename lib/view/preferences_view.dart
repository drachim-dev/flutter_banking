import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/common/keys.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/services/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesView extends StatefulWidget {
  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  Future<SharedPreferences> _prefsFuture = SharedPreferences.getInstance();
  SharedPreferences _prefs;

  String _selectedTheme = 'Light';

  bool _notifyOnTransaction = true;
  bool _notifyOnDocument = false;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void loadPreferences() {
    _prefsFuture.then((prefs) {
      _selectedTheme = prefs.getString(Keys.pref_theme) ?? _selectedTheme;
      _notifyOnTransaction =
          prefs.getBool(Keys.pref_notify_on_transaction) ?? _notifyOnTransaction;
      _notifyOnDocument =
          prefs.getBool(Keys.pref_notify_on_document) ?? _notifyOnDocument;

      _prefs = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: FutureBuilder(
        future: _prefsFuture,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.horizontalPadding,
                      vertical: Dimens.listVerticalPadding),
                  children: <Widget>[
                    _buildGroup(context, 'General'),
                    _buildThemeSelector(),
                    _buildGroup(context, 'Notifications'),
                    _buildTransactionNotifier(),
                    _buildDocumentNotifier(),
                    _buildGroup(context, 'Service'),
                    _buildAddressChange(),
                    _buildLockCard(),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildGroup(BuildContext context, String label) {
    final labelStyle =
        Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey);
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 16, bottom: 8),
      child: Text(
        label,
        style: labelStyle,
      ),
    );
  }

  Widget _buildThemeSelector() {
    return ListTile(
        title: Text('Design'),
        subtitle: Text(_selectedTheme),
        leading: Icon(Icons.color_lens),
        onTap: () async => showThemeDialog());
  }

  showThemeDialog() {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                  title: Text('Choose Theme'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile(
                          title: Text('Light'),
                          groupValue: _selectedTheme,
                          value: 'Light',
                          onChanged: (value) => setTheme(value)),
                      RadioListTile(
                          title: Text('Dark'),
                          groupValue: _selectedTheme,
                          value: 'Dark',
                          onChanged: (value) => setTheme(value)),
                      RadioListTile(
                          title: Text('Black'),
                          groupValue: _selectedTheme,
                          value: 'Black',
                          onChanged: (value) => setTheme(value)),
                    ],
                  )),
            ));
  }

  void setTheme(String value) async {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    themeNotifier.setTheme(MyTheme.getThemeFromName(value));

    _prefs.setString(Keys.pref_theme, value);
    setState(() {
      _selectedTheme = value;
    });
  }

  Widget _buildTransactionNotifier() {
    return SwitchListTile(
        title: Text('Spending'),
        secondary: Icon(Icons.monetization_on),
        value: _notifyOnTransaction,
        onChanged: (bool value) {
          _prefs.setBool(Keys.pref_notify_on_transaction, value);
          setState(() {
            _notifyOnTransaction = value;
          });
        });
  }

  Widget _buildDocumentNotifier() {
    return SwitchListTile(
        title: Text('Inbox'),
        secondary: Icon(Icons.mail),
        value: _notifyOnDocument,
        onChanged: (bool value) {
          _prefs.setBool(Keys.pref_notify_on_document, value);
          setState(() {
            _notifyOnDocument = value;
          });
        });
  }

  Widget _buildAddressChange() {
    return ListTile(
      title: Text('Change address'),
      leading: Icon(Icons.home),
      onTap: () {},
    );
  }

  Widget _buildLockCard() {
    return ListTile(
      title: Text('Lock card'),
      leading: Icon(Icons.lock),
      onTap: () {},
    );
  }
}
