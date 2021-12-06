import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/todo-screens/cart_screen.dart';
import 'package:zerodezenove/src/done-screens/home_screen.dart';
import 'package:zerodezenove/src/todo-screens/profile_screen.dart';
import 'package:zerodezenove/src/todo-screens/search_screen.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var _index = 0;
  var _theme = Style.getThemeData();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);

    _tabController.addListener(() => setState(() {
          _index = _tabController.index;
        }));

    _tabController.animation!.addListener(() {
      final value = _tabController.animation!.value;

      setState(() {
        if (value - _index > 0.5) _index = _index + 1;
        if (value - _index < -0.5) _index = _index - 1;
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
            physics: NeverScrollableScrollPhysics(),
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
                ),
                padding: Spacing.vertical(12),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: _theme.primaryColor,
                  tabs: <Widget>[
                    Container(
                      child: _getAppBar("Home", 0, FeatherIcons.home),
                    ),
                    Container(
                      child: _getAppBar("Search", 1, FeatherIcons.search),
                    ),
                    Container(
                      child: _getAppBar("Cart", 2, FeatherIcons.shoppingCart),
                    ),
                    Container(
                      child: _getAppBar("User", 3, FeatherIcons.user),
                    ),
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

  Widget _getAppBar(String name, int index, IconData icon) {
    var color =
        index == _index ? _theme.primaryColor : _theme.colorScheme.onBackground;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 25, color: color),
        FxText.b3(name, color: color),
      ],
    );
  }
}
