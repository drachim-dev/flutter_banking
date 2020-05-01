import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/colors.dart';

class SignUpLegitimationView extends StatelessWidget {
  final String identCode = 'KTGA17';

  SignUpLegitimationView();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.contact_phone,
                  size: 156,
                  color: MyColor.lightGrey,
                ),
                SizedBox(
                  height: 36,
                ),
                Text(
                  "ID Code",
                  style: theme.textTheme.headline3,
                ),
                FlatButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: identCode));
                      final snackBar = SnackBar(
                        content: Text('Copied to clipboard'),
                        duration: Duration(milliseconds: 4000),
                        behavior: SnackBarBehavior.floating,
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          identCode,
                          style: theme.textTheme.headline1,
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.content_copy, size: 36, color: MyColor.grey)
                      ],
                    )),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: OutlineButton(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text("Later"),
                  onPressed: () {}),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: RaisedButton.icon(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  label: Text("Identify now"),
                  icon: Icon(Icons.call),
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
