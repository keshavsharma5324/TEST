import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:life_wish/lang/app_localizations.dart';
import 'package:life_wish/lang/app_localizations_delegate.dart';
import 'package:life_wish/screen/EditProfileScreen.dart';
import 'package:life_wish/screen/LanguageScreen.dart';
import 'package:life_wish/screen/LicenceScreen.dart';
import 'package:life_wish/screen/MyLifeWish.dart';
import 'package:life_wish/screen/NewLifeWishesScreen.dart';
import 'package:life_wish/screen/NotificationScreen.dart';
import 'package:life_wish/screen/ReceiveLifeWish.dart';
import 'package:life_wish/theme/AppColor.dart';
import 'package:life_wish/theme/life_wish_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  AppLocalizationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    _newLocaleDelegate = AppLocalizationsDelegate(newLocale: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          child: Icon(Icons.menu),
          onTap: () {
            _drawerKey.currentState.openDrawer();
          },
        ),
        title: Image.asset(
          "assets/actionbar_icon.png",
          height: 30,
          width: 30,
        ),
        centerTitle: true,
        backgroundColor: transparent_color,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  );
                },
                child: Badge(
                  badgeColor: Colors.red,
                  shape: BadgeShape.circle,
                  toAnimate: true,
                  borderRadius: 5,
                  badgeContent:
                      Text('2', style: TextStyle(color: Colors.white)),
                  child: Icon(Icons.notifications),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: getDrawer(),
      body: SafeArea(
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 1,
                  color: dark_blue_color,
                ),
                Container(
                  height: viewportConstraints.maxHeight - 1,
                  width: viewportConstraints.maxWidth,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.only(left: 48),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home_screen_bg.png"),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewLifeWishesScreen()),
                              );
                            },
                            icon: Icon(
                              LifeWish.new_life_wish,
                              color: yellow_color,
                            ),
                            label: Text(
                              AppLocalizations.of(context)
                                  .translate('new_life_wishes'),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                        FlatButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyLifeWish()),
                              );
                            },
                            icon: Icon(
                              LifeWish.new_life_wish,
                              color: yellow_color,
                            ),
                            label: Text(
                              AppLocalizations.of(context)
                                  .translate('my_life_wishes'),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                        FlatButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReceiveLifeWish()),
                              );
                            },
                            icon: Icon(
                              LifeWish.receive_life_wish,
                              color: yellow_color,
                            ),
                            label: Text(
                              AppLocalizations.of(context)
                                  .translate('receive_life_wishes'),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  getDrawer() {
    return SafeArea(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: dark_blue_color,
              child: Column(
                children: <Widget>[
                  Align(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.clear,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  Align(
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        'AA',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: primaryColor),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    child: Text(
                      'AA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: primaryColor),
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: RaisedButton.icon(
                        color: yellow_color,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(4, 4)),
                        ),
                        icon: Icon(LifeWish.profile_setting),
                        label: Text(
                            AppLocalizations.of(context)
                                .translate('profile_settings'),
                            textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LanguageScreen()),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: dark_blue_color,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LifeWish.change_languaue,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 8, bottom: 8),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('change_language'),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: dark_blue_color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LifeWish.faq,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 8, bottom: 8),
                          child: Text(
                            AppLocalizations.of(context).translate('faq'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: dark_blue_color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LifeWish.contact_us,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 8, bottom: 8),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('contact_us'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: dark_blue_color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LifeWish.report_abuse,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 8, bottom: 8),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('report_abuse'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: dark_blue_color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LifeWish.privacy_policy,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 8, bottom: 8),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('privacy_policy'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LicenceScreen()),
                      );
                    },
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: dark_blue_color,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LifeWish.licence,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 8, bottom: 8),
                            child: Text(
                              AppLocalizations.of(context).translate('licence'),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 2,
              color: Colors.grey,
            ),
            Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Version Name: 1.0.0 (2)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )),
            Align(
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                child: FlatButton.icon(
                  color: yellow_color,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                  ),
                  icon: Icon(LifeWish.log_out),
                  label: Text(AppLocalizations.of(context).translate('signout'),
                      textAlign: TextAlign.center),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/loginScreen");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
