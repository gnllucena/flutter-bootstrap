import 'package:flutter/material.dart' hide Typography;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodezenove/src/configurations/localization.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/configurations/typography.dart';

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
    Typography.setTextDirection(textDirection);

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> updateLocalization(Language idiom) async {
    if (idiom.supportRTL) {
      updateDirection(TextDirection.rtl, false);
    } else {
      updateDirection(TextDirection.ltr, false);
    }

    await Localization.setLanguage(idiom);

    notifyListeners();
  }
}
