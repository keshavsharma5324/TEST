import 'package:flutter/material.dart';
import 'package:life_wish/Utils/CommonUtils.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LanguageScreenState();
  }
}

class LanguageScreenState extends State<LanguageScreen> {
  bool _selectedEnglish = false;
  bool _selectedSpanish = false;
  bool _selectedPortugese = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    setCurrentLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(AppLocalizations.of(context).translate('select_language'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          centerTitle: true,
          backgroundColor: transparent_color,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
            child: Center(
                child: Image.asset(
              "assets/app_logo.png",
              height: 150,
              width: 150,
            )),
          ),
          ListTile(
            title: Text('English',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            trailing: _selectedEnglish
                ? Icon(Icons.check_circle, color: Colors.white)
                : Icon(Icons.check_circle_outline, color: Colors.white),
            onTap: () {
              setState(() {
                setLanguage("English");
              });
            },
          ),
          ListTile(
            title: Text('Spanish',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            trailing: _selectedSpanish
                ? Icon(Icons.check_circle, color: Colors.white)
                : Icon(Icons.check_circle_outline, color: Colors.white),
            onTap: () {
              setState(() {
                setLanguage("Spanish");
              });
            },
          ),
          ListTile(
            title: Text('Portugese',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            trailing: _selectedPortugese
                ? Icon(Icons.check_circle, color: Colors.white)
                : Icon(Icons.check_circle_outline, color: Colors.white),
            onTap: () {
              setState(() {
                setLanguage("Portugese");
              });
            },
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              color: dark_blue_color,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
              ),
              child: RichText(
                  text: TextSpan(
                      text: AppLocalizations.of(context).translate('submit'),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              onPressed: () {
                /*Future<bool> loginStatus=CommonUtils.getLoginStatus();

                    loginStatus.then((bool loginStatus) {

                    });*/

                _prefs.then((SharedPreferences prefs) {
                  bool loginStatus = prefs.getBool(CommonUtils.LoginStatus);

                  if (loginStatus == null) {
                    Navigator.pushReplacementNamed(context, "/loginScreen");
                  } else if (loginStatus) {
                    Navigator.pushReplacementNamed(context, "/homeScreen");
                  } else {
                    Navigator.pushReplacementNamed(context, "/loginScreen");
                  }
                });
              },
            ),
          ),
        ],
      ),
    ));
  }

  setLanguage(String lang) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("lang", lang).then((bool success) {
      if (lang == "English") {
        AppLocalizations.load(Locale('en', ''));
        _selectedEnglish = true;
        _selectedSpanish = false;
        _selectedPortugese = false;
      } else if (lang == "Spanish") {
        AppLocalizations.load(Locale('es', ''));
        _selectedEnglish = false;
        _selectedSpanish = true;
        _selectedPortugese = false;
      } else if (lang == "Portugese") {
        AppLocalizations.load(Locale('pt', ''));
        _selectedEnglish = false;
        _selectedSpanish = false;
        _selectedPortugese = true;
      }

      setState(() {});
    });
  }

  setCurrentLanguage() async {
    _prefs.then((SharedPreferences prefs) {
      String lang = prefs.getString('lang');

      if (lang == null) {
        _selectedEnglish = false;
        _selectedSpanish = false;
        _selectedPortugese = false;
      } else if (lang == "English") {
        _selectedEnglish = true;
        _selectedSpanish = false;
        _selectedPortugese = false;
      } else if (lang == "Spanish") {
        _selectedEnglish = false;
        _selectedSpanish = true;
        _selectedPortugese = false;
      } else if (lang == "Portugese") {
        _selectedEnglish = false;
        _selectedSpanish = false;
        _selectedPortugese = true;
      }

      setState(() {});
    });
  }
}
