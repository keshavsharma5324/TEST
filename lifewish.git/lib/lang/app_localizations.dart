import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_wish/lang/app_localizations_delegate.dart';

class AppLocalizations {


  final Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppLocalizations(this.locale);

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) async {

    AppLocalizations appTranslations = AppLocalizations(locale);
    String jsonContent =
    await rootBundle.loadString('assets/locale/localization_${locale.languageCode}.json');
    _localisedValues = json.decode(jsonContent);
    return appTranslations;

  }

  String translate(String key) {
    return _localisedValues[key] ?? "$key not found";
  }

}




