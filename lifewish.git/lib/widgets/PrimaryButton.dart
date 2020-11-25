import 'package:flutter/material.dart';

import '../lang/app_localizations.dart';
import '../theme/AppColor.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final double width;

  const PrimaryButton(
      {@required this.onPressed, @required this.title, this.width})
      : assert(onPressed != null && title != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, top: 20),
      height: 50,
      width: width ?? MediaQuery.of(context).size.width - 60,
      child: RaisedButton(
        color: dark_blue_color,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
        ),
        child: RichText(
            text: TextSpan(
                text: AppLocalizations.of(context).translate(title),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        onPressed: onPressed,
      ),
    );
  }
}
