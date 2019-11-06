import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/common/my_theme.dart';
import 'package:flutter_banking/services/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesView extends StatefulWidget {
  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _notifyOnTransaction = true;
  bool _notifyOnDocument = false;

  Future<String> _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('theme') ?? 'light');
    });
  }

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
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalPadding,
              vertical: Dimensions.listVerticalPadding),
          children: <Widget>[
            _buildGroup(context, 'Allgemein'),
            FutureBuilder(
              future: _selectedTheme,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return _buildThemeSelector(snapshot.data);
                }
              },
            ),
            _buildGroup(context, 'Benachrichtungen'),
            _buildTransactionNotifier(),
            _buildDocumentNotifier(),
            _buildGroup(context, 'Service'),
            _buildAddressChange(),
            _buildLockCard(),
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

  Widget _buildThemeSelector(String selectedTheme) {
    return ListTile(
        title: Text('Design'),
        subtitle: Text(selectedTheme),
        leading: Icon(Icons.color_lens),
        onTap: () async => showThemeDialog(selectedTheme));
  }

  showThemeDialog(String selectedTheme) {
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
                          groupValue: selectedTheme,
                          value: 'Light',
                          onChanged: (value) => setTheme(value)),
                      RadioListTile(
                          title: Text('Dark'),
                          groupValue: selectedTheme,
                          value: 'Dark',
                          onChanged: (value) => setTheme(value)),
                    ],
                  )),
            ));
  }

  void setTheme(String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('theme', value);

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    themeNotifier.setTheme(MyTheme.getThemeFromName(value));

    setState(() {
      _selectedTheme = prefs.setString('theme', value).then((bool success) {
        return value;
      });
    });

  }

  Widget _buildTransactionNotifier() {
    return SwitchListTile(
        title: Text('Kontomelder'),
        secondary: Icon(Icons.monetization_on),
        value: _notifyOnTransaction,
        onChanged: (bool value) {
          setState(() {
            _notifyOnTransaction = value;
          });
        });
  }

  Widget _buildDocumentNotifier() {
    return SwitchListTile(
        title: Text('Postbox'),
        secondary: Icon(Icons.mail),
        value: _notifyOnDocument,
        onChanged: (bool value) {
          setState(() {
            _notifyOnDocument = value;
          });
        });
  }

  Widget _buildAddressChange() {
    return ListTile(
      title: Text('Adressänderung'),
      leading: Icon(Icons.home),
      onTap: () {},
    );
  }

  Widget _buildLockCard() {
    return ListTile(
      title: Text('Karte sperren'),
      leading: Icon(Icons.lock),
      onTap: () {},
    );
  }
}
