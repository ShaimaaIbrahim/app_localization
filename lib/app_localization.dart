import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLocalization {

  Locale locale;

  AppLocalization({this.locale});

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static  LocalizationsDelegate<AppLocalization> delegete =
    AppLocalizationDelegete();


  Map<String, String> _localizationString;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizationString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) {
    return _localizationString[key];
  }
}


class AppLocalizationDelegete extends LocalizationsDelegate<AppLocalization>{

  @override
  bool isSupported(Locale locale) {
   return ['en' , 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = new AppLocalization(locale: locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
   return false;
  }

}