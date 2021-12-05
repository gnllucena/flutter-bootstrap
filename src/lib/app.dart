import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/screens/cart_screen.dart';
import 'package:zerodezenove/screens/home_screen.dart';
import 'package:zerodezenove/screens/profile_screen.dart';
import 'package:zerodezenove/screens/search_screen.dart';
import 'package:zerodezenove/widgets/FX/text/text.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var _currentIndex = 0;
  var _customTheme = CustomStyle.getThemeData();
  var _theme = Style.getThemeData();
  var _isDark = Style.getCurrentTheme() == Styles.dark;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);

    _tabController.addListener(() => setState(() {
          _currentIndex = _tabController.index;
        }));

    _tabController.animation!.addListener(() {
      final value = _tabController.animation!.value;

      setState(() {
        if (value - _currentIndex > 0.5) _currentIndex = _currentIndex + 1;
        if (value - _currentIndex < -0.5) _currentIndex = _currentIndex - 1;
      });
    });
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
      // drawer: _buildDrawer(),
    );
  }
}
