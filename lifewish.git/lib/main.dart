import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:life_wish/theme/AppColor.dart';

import 'Utils/app_route.dart';
import 'lang/app_localizations.dart';
import 'lang/app_localizations_delegate.dart';

void main() async {
  /*
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
  */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        // locale: DevicePreview.of(context).locale,
        // builder: DevicePreview.appBuilder,
        title: 'Life Wish',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", ""),
          const Locale("es", ""),
          const Locale("pt", ""),
        ],
        theme: ThemeData(
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white)),
          primaryColor: primaryColor,
          appBarTheme:
              AppBarTheme(color: Colors.white, brightness: Brightness.light),
          fontFamily: 'Nunito',
          backgroundColor: primaryColor,
          scaffoldBackgroundColor: primaryColor,
          applyElevationOverlayColor: false,
        ),
        color: Colors.yellow,
        routes: getAppRoute(),
      ),
    );
  }
}
