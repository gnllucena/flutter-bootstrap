import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter/material.dart' hide Typography;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:zerodezenove/env.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zerodezenove/src/configurations/localization.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/configurations/typography.dart';
import 'package:zerodezenove/src/notifiers/settings_notifier.dart';
import 'package:zerodezenove/src/todo-screens/select_language_dialog.dart';
import 'package:zerodezenove/src/widgets/FX/button/button.dart';
import 'package:zerodezenove/src/widgets/FX/container/container.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({Key? key}) : super(key: key);

  @override
  _AppSettingScreenState createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
  }

  void changeDirection() {
    if (Typography.getTextDirection() == TextDirection.ltr) {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateDirection(TextDirection.rtl);
    } else {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateDirection(TextDirection.ltr);
    }
    setState(() {});
  }

  void changeTheme() {
    if (Style.getCurrentTheme() == Styles.light) {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateTheme(Styles.dark);
    } else {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateTheme(Styles.light);
    }

    setState(() {});
  }

  void launchCodecanyonURL() async {
    String url = "https://1.envato.market/flutkit";
    await launch(url);
  }

  void launchDocumentation() async {
    String url = "https://flutkit.coderthemes.com/index.html";
    await launch(url);
  }

  void launchChangeLog() async {
    String url = "https://flutkit.coderthemes.com/changlog.html";
    await launch(url);
  }

  Icon autoDirection(Icon icon) {
    if (Typography.getTextDirection() == TextDirection.ltr) {
      return icon;
    }

    if (icon == FeatherIcons.chevronRight) {
      return Icon(
        FeatherIcons.chevronLeft,
        color: icon.color,
        textDirection: icon.textDirection,
        size: icon.size,
        key: icon.key,
        semanticLabel: icon.semanticLabel,
      );
    } else if (icon == FeatherIcons.chevronLeft) {
      return Icon(
        FeatherIcons.chevronRight,
        color: icon.color,
        textDirection: icon.textDirection,
        size: icon.size,
        key: icon.key,
        semanticLabel: icon.semanticLabel,
      );
    } else if (icon == MdiIcons.chevronLeft) {
      return Icon(
        MdiIcons.chevronRight,
        color: icon.color,
        textDirection: icon.textDirection,
        size: icon.size,
        key: icon.key,
        semanticLabel: icon.semanticLabel,
      );
    } else if (icon == MdiIcons.chevronRight) {
      return Icon(
        MdiIcons.chevronLeft,
        color: icon.color,
        textDirection: icon.textDirection,
        size: icon.size,
        key: icon.key,
        semanticLabel: icon.semanticLabel,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (BuildContext context, SettingsNotifier value, Widget? child) {
        isDark = Style.getCurrentTheme() == Styles.dark;
        return Theme(
          data: Style.getThemeData().copyWith(
              colorScheme: Style.getThemeData().colorScheme.copyWith(
                  secondary:
                      Style.getThemeData().colorScheme.primary.withAlpha(80))),
          child: Scaffold(
            body: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  Navigator.pop(context);
                }
              },
              child: ListView(
                padding: Spacing.fromLTRB(4, 80, 4, 70),
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: autoDirection(Icon(
                          FeatherIcons.chevronLeft,
                          size: 20,
                          color: Style.getThemeData().colorScheme.onBackground,
                        )),
                      ),
                      Spacing.width(16),
                      FxText.sh1(
                        Localization.translate("settings"),
                        fontWeight: 600,
                      ),
                    ],
                  ),
                  Spacing.height(20),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SelectLocalizationDialog());
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(Images.languageOutline),
                            color: CustomStyle.getThemeData().peach,
                          ),
                          background:
                              CustomStyle.getThemeData().peach.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Localization.translate("language"),
                          ),
                        ),
                        Spacing.width(16),
                        autoDirection(Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: Style.getThemeData().colorScheme.onBackground,
                        )),
                      ],
                    ),
                  ),
                  Spacing.height(20),
                  InkWell(
                    onTap: () {
                      changeDirection();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(Typography.getTextDirection() ==
                                    TextDirection.ltr
                                ? Images.paragraphRTLOutline
                                : Images.paragraphLTROutline),
                            color: CustomStyle.getThemeData().skyBlue,
                          ),
                          background:
                              CustomStyle.getThemeData().skyBlue.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Typography.getTextDirection() == TextDirection.ltr
                                ? Localization.translate("right_to_left") +
                                    " (RTL)"
                                : Localization.translate("left_to_right") +
                                    " (LTR)",
                          ),
                        ),
                        Spacing.width(16),
                        autoDirection(Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: Style.getThemeData().colorScheme.onBackground,
                        )),
                      ],
                    ),
                  ),
                  Spacing.height(20),
                  InkWell(
                    onTap: () {
                      changeTheme();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          background:
                              CustomStyle.getThemeData().occur.withAlpha(28),
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(!isDark
                                ? Images.darkModeOutline
                                : Images.lightModeOutline),
                            color: CustomStyle.getThemeData().occur,
                          ),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            !isDark
                                ? Localization.translate("dark_mode")
                                : Localization.translate("light_mode"),
                          ),
                        ),
                        Spacing.width(16),
                        autoDirection(Icon(
                          FeatherIcons.chevronRight,
                          size: 18,
                          color: Style.getThemeData().colorScheme.onBackground,
                        )),
                      ],
                    ),
                  ),
                  Spacing.height(20),
                  Divider(),
                  Spacing.height(20),
                  InkWell(
                    onTap: () {
                      launchDocumentation();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(Images.documentationIcon),
                            color: CustomStyle.getThemeData().skyBlue,
                          ),
                          background:
                              CustomStyle.getThemeData().skyBlue.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Localization.translate("documentation"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacing.height(20),
                  InkWell(
                    onTap: () {
                      launchChangeLog();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        FxContainer(
                          paddingAll: 12,
                          borderRadiusAll: 4,
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(Images.changeLogIcon),
                            color: CustomStyle.getThemeData().peach,
                          ),
                          background:
                              CustomStyle.getThemeData().peach.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Localization.translate("changelog"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacing.height(20),
                  Center(
                    child: FxButton(
                      borderRadiusAll: 4,
                      elevation: 0,
                      onPressed: () {
                        launchCodecanyonURL();
                      },
                      splashColor: Style.getThemeData()
                          .colorScheme
                          .onPrimary
                          .withAlpha(40),
                      child: FxText.button(
                        Localization.translate("buy_now"),
                        color: Style.getThemeData().colorScheme.onPrimary,
                        letterSpacing: 0.5,
                      ),
                      backgroundColor: Style.getThemeData().colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
