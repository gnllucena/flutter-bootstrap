import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zerodezenove/app.dart';
import 'package:zerodezenove/configurations/language.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/configurations/writing.dart';
import 'package:zerodezenove/notifiers/settings_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<SettingsNotifier>(
      create: (context) => SettingsNotifier(),
      child: ChangeNotifierProvider<SettingsNotifier>(
        create: (context) => SettingsNotifier(),
        child: Main(),
      ),
    ));
  });
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (BuildContext context, SettingsNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Style.getTheme(),
          builder: (context, child) {
            return Directionality(
              textDirection: Writing.getTextDirection(),
              child: child!,
            );
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),
          home: App(),
        );
      },
    );
  }
}
