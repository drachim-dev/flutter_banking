import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';

class SignUpLegitimationView extends StatelessWidget {
  SignUpLegitimationView();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 96),
          Text(
            "Almost done",
            textAlign: TextAlign.center,
            style: theme.textTheme.headline1,
          ),
          SizedBox(height: 24,),
          Icon(
            Icons.contact_phone,
            size: 156,
            color: MyColor.lightGrey,
          ),
          SizedBox(height: 24,),
          Text(
            "Your ID code: 5D79KA",
            textAlign: TextAlign.center,
            style: theme.textTheme.headline4,
          ),
        ],
      ),
      Positioned(
        left: 16,
        right: 16,
        bottom: 16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text("Later"),
                  onPressed: () {}),
            ),
            SizedBox(width: 16,),
            Expanded(
              child: RaisedButton.icon(
                  // padding: const EdgeInsets.symmetric(vertical: 8), // was recently merged in master https://github.com/flutter/flutter/pull/52393
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
    ]);
  }
}
