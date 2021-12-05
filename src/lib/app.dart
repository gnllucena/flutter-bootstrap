import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zerodezenove/configurations/language.dart';
import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/configurations/writing.dart';
import 'package:zerodezenove/notifiers/settings_notifier.dart';
import 'package:zerodezenove/screens/cart_screen.dart';
import 'package:zerodezenove/screens/home_screen.dart';
import 'package:zerodezenove/screens/profile_screen.dart';
import 'package:zerodezenove/screens/search_screen.dart';
import 'package:zerodezenove/screens/select_language_dialog.dart';
import 'package:zerodezenove/env.dart';
import 'package:zerodezenove/widgets/FX/button/button.dart';
import 'package:zerodezenove/widgets/FX/container/container.dart';
import 'package:zerodezenove/widgets/FX/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int _currentIndex = 0;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late TabController tabController;

  bool isDark = false;
  TextDirection textDirection = TextDirection.ltr;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.animation!.addListener(() {
      final aniValue = _tabController!.animation!.value;

      if (aniValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
  }

  Icon autoDirection(Icon icon) {
    if (Writing.getTextDirection() == TextDirection.ltr) {
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

  void changeDirection() {
    if (Writing.getTextDirection() == TextDirection.ltr) {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateDirection(TextDirection.rtl);
    } else {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateDirection(TextDirection.ltr);
    }
    setState(() {});
  }

  void changeTheme() {
    if (Style.getTheme() == Styles.light) {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateTheme(Styles.dark);
    } else {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateTheme(Styles.light);
    }

    setState(() {});
  }

  void launchCodecanyonURL() async {
    String url = "https://codecanyon.net/user/coderthemes/portfolio";
    await launch(url);
  }

  void launchDocumentation() async {
    String url = "http://onekit.coderthemes.com/index.html";
    await launch(url);
  }

  void launchChangeLog() async {
    String url = "http://onekit.coderthemes.com/changlog.html";
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              HomeScreen(rootContext: context),
              GrocerySearchScreen(rootContext: context),
              GroceryCartScreen(rootContext: context),
              GroceryProfileScreen(rootContext: context)
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: Spacing.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: CustomStyle.getThemeData().card.withAlpha(220),
                  // borderRadius: Shape.circular(16)
                ),
                padding: Spacing.vertical(12),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Style.getThemeData().primaryColor,
                  tabs: <Widget>[
                    Container(
                      child: (_currentIndex == 0)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FxText.b2("Home",
                                    color: Style.getThemeData().primaryColor,
                                    letterSpacing: 0,
                                    fontWeight: 600),
                                Container(
                                  margin: Spacing.top(6),
                                  decoration: BoxDecoration(
                                      color: Style.getThemeData().primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.5))),
                                  height: 5,
                                  width: 5,
                                )
                              ],
                            )
                          : Icon(
                              FeatherIcons.home,
                              size: 20,
                              color:
                                  Style.getThemeData().colorScheme.onBackground,
                            ),
                    ),
                    Container(
                        child: (_currentIndex == 1)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FxText.b2("Search",
                                      color: Style.getThemeData().primaryColor,
                                      letterSpacing: 0,
                                      fontWeight: 600),
                                  Container(
                                    margin: Spacing.top(6),
                                    decoration: BoxDecoration(
                                        color:
                                            Style.getThemeData().primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                FeatherIcons.search,
                                size: 20,
                                color: Style.getThemeData()
                                    .colorScheme
                                    .onBackground,
                              )),
                    Container(
                        child: (_currentIndex == 2)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FxText.b2("Cart",
                                      color: Style.getThemeData().primaryColor,
                                      letterSpacing: 0,
                                      fontWeight: 600),
                                  Container(
                                    margin: Spacing.top(6),
                                    decoration: BoxDecoration(
                                        color:
                                            Style.getThemeData().primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                FeatherIcons.shoppingCart,
                                size: 20,
                                color: Style.getThemeData()
                                    .colorScheme
                                    .onBackground,
                              )),
                    Container(
                        child: (_currentIndex == 3)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FxText.b2("Profile",
                                      color: Style.getThemeData().primaryColor,
                                      letterSpacing: 0,
                                      fontWeight: 600),
                                  Container(
                                    margin: Spacing.top(6),
                                    decoration: BoxDecoration(
                                        color:
                                            Style.getThemeData().primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                FeatherIcons.user,
                                size: 20,
                                color: Style.getThemeData()
                                    .colorScheme
                                    .onBackground,
                              )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildDrawer() {
    return FxContainer.none(
      margin: Spacing.fromLTRB(16, Spacing.safeAreaTop(context) + 16, 16, 16),
      borderRadiusAll: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      background: Style.getThemeData().scaffoldBackgroundColor,
      child: Drawer(
          child: Container(
        color: Style.getThemeData().scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: Spacing.only(left: 20, bottom: 24, top: 24, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage(Images.brandLogo),
                    height: 102,
                    width: 102,
                  ),
                  Spacing.height(16),
                  FxContainer(
                    padding: Spacing.fromLTRB(12, 4, 12, 4),
                    borderRadiusAll: 4,
                    background:
                        Style.getThemeData().colorScheme.primary.withAlpha(40),
                    child: FxText.caption("v. 8.0.0",
                        color: Style.getThemeData().colorScheme.primary,
                        fontWeight: 600,
                        letterSpacing: 0.2),
                  ),
                ],
              ),
            ),
            Spacing.height(32),
            Container(
              margin: Spacing.x(20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SelectLanguageDialog());
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
                            color: CustomStyle.peach,
                          ),
                          background: CustomStyle.peach.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Language.translate("language"),
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
                            image: AssetImage(
                                Writing.getTextDirection() == TextDirection.ltr
                                    ? Images.paragraphRTLOutline
                                    : Images.paragraphLTROutline),
                            color: CustomStyle.skyBlue,
                          ),
                          background: CustomStyle.skyBlue.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Writing.getTextDirection() == TextDirection.ltr
                                ? Language.translate("right_to_left") + " (RTL)"
                                : Language.translate("left_to_right") +
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
                          background: CustomStyle.occur.withAlpha(20),
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(!isDark
                                ? Images.darkModeOutline
                                : Images.lightModeOutline),
                            color: CustomStyle.occur,
                          ),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            !isDark
                                ? Language.translate("dark_mode")
                                : Language.translate("light_mode"),
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
                ],
              ),
            ),
            Spacing.height(20),
            Divider(
              thickness: 1,
            ),
            Spacing.height(16),
            Container(
              margin: Spacing.x(20),
              child: Column(
                children: [
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
                            color: CustomStyle.skyBlue,
                          ),
                          background: CustomStyle.skyBlue.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Language.translate("documentation"),
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
                            color: CustomStyle.peach,
                          ),
                          background: CustomStyle.peach.withAlpha(20),
                        ),
                        Spacing.width(16),
                        Expanded(
                          child: FxText.b1(
                            Language.translate("changelog"),
                          ),
                        ),
                      ],
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
                splashColor:
                    Style.getThemeData().colorScheme.onPrimary.withAlpha(40),
                child: FxText(
                  Language.translate("buy_now"),
                  color: Style.getThemeData().colorScheme.onPrimary,
                ),
                backgroundColor: Style.getThemeData().colorScheme.primary,
              ),
            )
          ],
        ),
      )),
    );
  }
}

class NavItem {
  final String title;
  final String icon;
  final Widget screen;
  final double size;

  NavItem(this.title, this.icon, this.screen, [this.size = 28]);
}
