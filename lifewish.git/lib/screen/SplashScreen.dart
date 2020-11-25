import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/repository/AppRepository.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setCurrentLanguage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Center(
          child: Center(
              child: Image.asset(
            "assets/app_logo.png",
            height: 150,
            width: 150,
          )),
        ),
      ),
    );
  }

  goToNextScreen() async {
    Navigator.pushReplacementNamed(context, "/loginScreen");
  }

  setCurrentLanguage() async {
    _prefs.then((SharedPreferences prefs) {
      String lang = prefs.getString('lang');

      if (lang == null) {
        Navigator.pushReplacementNamed(context, "/languageScreen");
      } else if (lang == "English") {
        AppLocalizations.load(Locale('en', ''));
        goToNextScreen();
      } else if (lang == "Spanish") {
        AppLocalizations.load(Locale('es', ''));
        goToNextScreen();
      } else if (lang == "Portugese") {
        AppLocalizations.load(Locale('pt', ''));
        goToNextScreen();
      }

      setState(() {});
    });
  }
}
