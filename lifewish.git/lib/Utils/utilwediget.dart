import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';

import '../theme/AppColor.dart';

getSnackBar(String msg, String actionLable) {
  final snackBar = SnackBar(
    backgroundColor: dark_blue_color,
    content: Text(
      msg,
      style: TextStyle(color: Colors.white),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: actionLable,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  return snackBar;
}

Widget logoWidget() {
  return Image.asset(
    "assets/app_logo.png",
    height: 150,
    width: 150,
  );
}

Widget termOfServiceAndPrivacyWidget(context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: AppLocalizations.of(context)
            .translate('tapping_create_an_account_agree'),
        style: TextStyle(color: lite_blue_color, fontSize: 14),
        children: <TextSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => _handleLink(0),
            text: AppLocalizations.of(context).translate('terms_of_use'),
            style: TextStyle(
                color: lite_blue_color,
                fontSize: 14,
                decoration: TextDecoration.underline),
          ),
          TextSpan(
            text: AppLocalizations.of(context).translate('and'),
            style: TextStyle(color: lite_blue_color, fontSize: 14),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => _handleLink(1),
            text: AppLocalizations.of(context).translate('privacy_policy'),
            style: TextStyle(
                color: lite_blue_color,
                fontSize: 14,
                decoration: TextDecoration.underline),
          )
        ]),
  );
}

_handleLink(number) {
  print("Opening the link $number");
}

Future<void> showMyDialog({context, title, msg, actions}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg),
            ],
          ),
        ),
        actions: actions,
      );
    },
  );
}
