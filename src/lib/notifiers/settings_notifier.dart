import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodezenove/configurations/language.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/configurations/writing.dart';

class SettingsNotifier extends ChangeNotifier {
  init() async {
    var preferences = await SharedPreferences.getInstance();
    var theme = preferences.getString("theme_mode").toString() == "dark"
        ? Styles.dark
        : Styles.light;

    Style.setTheme(theme);

    notifyListeners();
  }

  void updateTheme(Styles theme) async {
    Style.setTheme(theme);

    notifyListeners();
  }

  void updateDirection(TextDirection textDirection, [bool notify = true]) {
    Writing.setTextDirection(textDirection);

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> updateLanguage(Idiom idiom) async {
    if (idiom.supportRTL) {
      updateDirection(TextDirection.rtl, false);
    } else {
      updateDirection(TextDirection.ltr, false);
    }

    await Language.setIdiom(idiom);

    notifyListeners();
  }
}
