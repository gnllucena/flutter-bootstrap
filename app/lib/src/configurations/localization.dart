import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodezenove/src/notifiers/settings_notifier.dart';

class Localization {
  static Map<String, String>? _localized;

  static Language _currentLanguage = _languages.first;

  static List<Language> _languages = [
    Language(Locale('en'), "English"),
    Language(Locale('hi'), "Hindi"),
    Language(
      Locale('ar'),
      "Arabic",
      true,
    ),
    Language(Locale('fr'), "French"),
    Language(Locale('zh'), "Chinese"),
  ];

  static Future<bool> init() async {
    _currentLanguage = await getLanguage();

    return true;
  }

  static String translate(String text) {
    if (_localized != null) {
      var value = _localized![text];

      return value == null ? text : value;
    }

    return text;
  }

  static List<Language> getLanguages() {
    return _languages;
  }

  static Language getLanguageFromCode(String code) {
    var idiom = _languages.first;

    _languages.forEach((Language i) {
      if (i.locale.languageCode == code) {
        idiom = i;
      }
    });

    return idiom;
  }

  static Language? getLanguageFromLocale(Locale locale) {
    for (var idiom in _languages) {
      if (idiom.locale.languageCode == locale.languageCode) {
        return idiom;
      }
    }
  }

  static Language getCurrentLanguage() {
    return _currentLanguage;
  }

  static List<String> getLocalizationCode() {
    return _languages.map((e) => e.locale.languageCode).toList();
  }

  static List<Locale> getLocales() {
    return _languages.map((e) => e.locale).toList();
  }

  static Future<Language> getLanguage() async {
    Language? idiom;

    var preferences = await SharedPreferences.getInstance();
    var code = preferences.getString("lang_code");

    if (code != null) {
      idiom = getLanguageFromLocale(Locale(code));
    }

    return idiom ?? _languages.first;
  }

  static Future<bool> setLanguage(Language idiom) async {
    var intl = await rootBundle
        .loadString('assets/lang/${idiom.locale.languageCode}.json');

    Map<String, dynamic> map = json.decode(intl);

    _localized = map.map((key, value) {
      return MapEntry(key, value.toString());
    });

    var preferences = await SharedPreferences.getInstance();
    preferences.setString("lang_code", idiom.locale.languageCode);

    return true;
  }
}

class Language {
  final Locale locale;
  final bool supportRTL;
  final String name;

  Language(this.locale, this.name, [this.supportRTL = false]);
}

class AppLocalizationsDelegate extends LocalizationsDelegate {
  final BuildContext context;

  const AppLocalizationsDelegate(this.context);

  @override
  bool isSupported(Locale locale) =>
      Localization.getLocalizationCode().contains(locale.languageCode);

  @override
  Future load(Locale locale) => _load(locale);

  Future _load(Locale locale) async {
    Provider.of<SettingsNotifier>(context, listen: false).updateLocalization(
        Localization.getLanguageFromCode(locale.languageCode));
    return;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
