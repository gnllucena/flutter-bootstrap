import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodezenove/src/notifiers/settings_notifier.dart';

class Language {
  static Map<String, String>? _localized;

  static Idiom _currentIdiom = _idioms.first;

  static List<Idiom> _idioms = [
    Idiom(Locale('en'), "English"),
    Idiom(Locale('hi'), "Hindi"),
    Idiom(
      Locale('ar'),
      "Arabic",
      true,
    ),
    Idiom(Locale('fr'), "French"),
    Idiom(Locale('zh'), "Chinese"),
  ];

  static Future<bool> init() async {
    _currentIdiom = await getIdiom();

    return true;
  }

  static String translate(String text) {
    if (_localized != null) {
      var value = _localized![text];

      return value == null ? text : value;
    }

    return text;
  }

  static List<Idiom> getIdioms() {
    return _idioms;
  }

  static Idiom getIdiomFromCode(String code) {
    var idiom = _idioms.first;

    _idioms.forEach((Idiom i) {
      if (i.locale.languageCode == code) {
        idiom = i;
      }
    });

    return idiom;
  }

  static Idiom? getIdiomFromLocale(Locale locale) {
    for (var idiom in _idioms) {
      if (idiom.locale.languageCode == locale.languageCode) {
        return idiom;
      }
    }
  }

  static Idiom getCurrentIdiom() {
    return _currentIdiom;
  }

  static List<String> getLanguageCode() {
    return _idioms.map((e) => e.locale.languageCode).toList();
  }

  static List<Locale> getLocales() {
    return _idioms.map((e) => e.locale).toList();
  }

  static Future<Idiom> getIdiom() async {
    Idiom? idiom;

    var preferences = await SharedPreferences.getInstance();
    var code = preferences.getString("lang_code");

    if (code != null) {
      idiom = getIdiomFromLocale(Locale(code));
    }

    return idiom ?? _idioms.first;
  }

  static Future<bool> setIdiom(Idiom idiom) async {
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

class Idiom {
  final Locale locale;
  final bool supportRTL;
  final String name;

  Idiom(this.locale, this.name, [this.supportRTL = false]);
}

class AppLocalizationsDelegate extends LocalizationsDelegate {
  final BuildContext context;

  const AppLocalizationsDelegate(this.context);

  @override
  bool isSupported(Locale locale) =>
      Language.getLanguageCode().contains(locale.languageCode);

  @override
  Future load(Locale locale) => _load(locale);

  Future _load(Locale locale) async {
    Provider.of<SettingsNotifier>(context, listen: false)
        .updateLanguage(Language.getIdiomFromCode(locale.languageCode));
    return;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
