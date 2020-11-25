import 'package:flutter/material.dart';

import 'app_localizations.dart';
import 'application.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {

  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.

  final Locale newLocale;


  const AppLocalizationsDelegate({this.newLocale});


  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;


}

