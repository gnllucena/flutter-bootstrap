import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zerodezenove/configurations/language.dart';
import 'package:zerodezenove/configurations/routes/slide_left_route.dart';
import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/todo-screens/app_setting_screen.dart';
import 'package:zerodezenove/domain/category.dart';
import 'package:zerodezenove/domain/product.dart';
import 'package:zerodezenove/env.dart';
import 'package:zerodezenove/todo-screens/category_screen.dart';
import 'package:zerodezenove/todo-screens/notification_dialog.dart';
import 'package:zerodezenove/todo-screens/single_product_screen.dart';
import 'package:zerodezenove/widgets/FX/container/container.dart';
import 'package:zerodezenove/widgets/FX/text/text.dart';

class HomeScreen extends StatefulWidget {
  final BuildContext rootContext;

  const HomeScreen({Key? key, required this.rootContext}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late List<Category> _categories;
  late List<Product> _products;
  ThemeData _theme = Style.getThemeData();

  @override
  initState() {
    super.initState();
    _categories = Category.getList();
    _products = Product.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: Spacing.fromLTRB(12, 72, 12, 70),
      children: <Widget>[
        Padding(
          padding: Spacing.horizontal(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.h6("Hi, Gabriel!",
                  color: _theme.colorScheme.onBackground, fontWeight: 600),

              //https://api.flutter.dev/flutter/material/InkResponse-class.html
              InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return NotificationDialog();
                      },
                      fullscreenDialog: true));
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Icon(
                      FeatherIcons.bell,
                      size: 22,
                      color: _theme.colorScheme.onBackground.withAlpha(200),
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: Spacing.zero,
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            color: _theme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: Center(
                          child: FxText.overline(
                            "2",
                            color: _theme.backgroundColor,
                            fontSize: 9,
                            fontWeight: 500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.push(context, SlideLeftRoute(AppSettingScreen())),
                child: Container(
                  child: Image(
                    image: AssetImage(Images.settingIcon),
                    color: _theme.colorScheme.onBackground,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacing.height(8),
        Padding(
          padding: Spacing.horizontal(24),
          child: FxText.b2("What would you buy today?",
              color: _theme.colorScheme.onBackground,
              fontWeight: 500,
              xMuted: true),
        ),
        Spacing.height(24),
        getBannerWidget(),
        Spacing.height(24),
        Padding(
          padding: Spacing.horizontal(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.sh1("Categories",
                  letterSpacing: 0,
                  color: _theme.colorScheme.onBackground,
                  fontWeight: 600),
              FxText.caption("See All",
                  color: _theme.colorScheme.onBackground,
                  fontWeight: 600,
                  xMuted: true,
                  letterSpacing: 0),
            ],
          ),
        ),
        Spacing.height(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: buildCategories(),
          ),
        ),
        Spacing.height(24),
        Padding(
          padding: Spacing.horizontal(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.sh1("Best Selling",
                  color: _theme.colorScheme.onBackground, fontWeight: 600),
              FxText.caption("See All",
                  color: _theme.colorScheme.onBackground,
                  fontWeight: 600,
                  xMuted: true,
                  letterSpacing: 0),
            ],
          ),
        ),
        Spacing.height(16),
        Padding(
          padding: Spacing.horizontal(24),
          child: Column(
            children: buildProducts(),
          ),
        )
      ],
    ));
  }

  List<Widget> buildProducts() {
    List<Widget> list = [];

    for (Product product in _products) {
      list.add(getSingleProduct(product));
    }

    return list;
  }

  Widget getBannerWidget() {
    return FxContainer(
      background: _theme.primaryColor.withAlpha(28),
      padding: Spacing.all(24),
      margin: Spacing.horizontal(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.b1("Enjoy the special offer\nup to 60%",
              color: _theme.primaryColor, fontWeight: 600, letterSpacing: 0),
          Spacing.height(8),
          FxText.caption("at 15 - 25 March 2021",
              color: _theme.colorScheme.onBackground.withAlpha(100),
              fontWeight: 500,
              letterSpacing: -0.2),
        ],
      ),
    );
  }

  List<Widget> buildCategories() {
    List<Widget> list = [];
    list.add(Spacing.width(24));
    for (int i = 0; i < _categories.length; i++) {
      list.add(getSingleCategory(_categories[i]));
      list.add(Spacing.width(16));
    }
    return list;
  }

  static String doubleToString(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  Widget getSingleCategory(Category category) {
    String heroTag = category.image;

    return Hero(
      tag: heroTag,
      child: FxContainer(
        width: 80,
        onTap: () {
          Navigator.push(
              widget.rootContext,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) =>
                      GroceryCategoryScreen(context, category, heroTag)));
        },
        padding: Spacing.all(16),
        background: category.color,
        child: Column(
          children: [
            Image.asset(
              category.image,
              width: 28,
              height: 28,
            ),
            Spacing.height(4),
            FxText.overline(
              category.title,
              color: _theme.colorScheme.onBackground,
            )
          ],
        ),
      ),
    );
  }

  Widget getSingleProduct(Product product) {
    String heroKey = product.name;

    return InkWell(
      onTap: () {
        Navigator.push(
            widget.rootContext,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    GrocerySingleProductScreen(product, heroKey)));
      },
      child: FxContainer(
        margin: Spacing.bottom(16),
        background: _theme.primaryColor.withAlpha(32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              background: _theme.primaryColor.withAlpha(32),
              padding: Spacing.all(8),
              child: Hero(
                tag: heroKey,
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    product.image,
                    width: 72,
                    height: 72,
                  ),
                ),
              ),
            ),
            Spacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.b2(product.name,
                      color: _theme.colorScheme.onBackground, fontWeight: 600),
                  Spacing.height(8),
                  FxText.overline(product.description,
                      color: _theme.colorScheme.onBackground, muted: true),
                  Spacing.height(8),
                  product.discountedPrice != product.price
                      ? Row(
                          children: [
                            FxText.caption("\$" + doubleToString(product.price),
                                decoration: TextDecoration.lineThrough,
                                fontWeight: 500),
                            // Space.width(8),
                            Spacing.width(8),
                            FxText.b2(
                                "\$" + doubleToString(product.discountedPrice),
                                color: _theme.colorScheme.onBackground,
                                fontWeight: 700),
                          ],
                        )
                      : FxText.b2("\$" + doubleToString(product.price),
                          color: _theme.colorScheme.onBackground,
                          fontWeight: 700),
                ],
              ),
            ),
            Icon(
              MdiIcons.heartOutline,
              color: _theme.primaryColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
