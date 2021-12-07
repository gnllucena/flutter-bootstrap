import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zerodezenove/env.dart';
import 'package:zerodezenove/src/configurations/routes/slide_left_route.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/domain/category.dart';
import 'package:zerodezenove/src/domain/product.dart';
import 'package:zerodezenove/src/todo-screens/app_setting_screen.dart';
import 'package:zerodezenove/src/todo-screens/category_screen.dart';
import 'package:zerodezenove/src/todo-screens/single_product_screen.dart';
import 'package:zerodezenove/src/widgets/FX/container/container.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';
import 'package:zerodezenove/src/widgets/paragraph/paragraph.dart';
import 'package:zerodezenove/src/widgets/screen/screen.dart';
import 'package:zerodezenove/src/widgets/card/card.dart';

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
  late ThemeData _theme;

  @override
  initState() {
    super.initState();
    _categories = Category.getList();
    _products = Product.getList();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Screen(
      children: <Widget>[
        Paragraph(
          children: [
            FxText.h6(
              "Hi, Gabriel!",
              color: _theme.colorScheme.onBackground,
              fontWeight: 600,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                SlideLeftRoute(AppSettingScreen()),
              ),
              child: Container(
                child: Image(
                  image: AssetImage(Images.settingIcon),
                  color: _theme.colorScheme.onBackground,
                  width: 24,
                  height: 24,
                ),
              ),
            )
          ],
        ),
        Spacing.height(8),
        Paragraph(
          children: [
            FxText.b2(
              "What would you buy today?",
              color: _theme.colorScheme.onBackground,
              fontWeight: 500,
              xMuted: true,
            )
          ],
        ),
        Spacing.height(24),
        Card(
          background: _theme.primaryColor.withAlpha(28),
          padding: Spacing.all(24),
          margin: Spacing.horizontal(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.b1("Enjoy the special offer\nup to 60%",
                      color: _theme.primaryColor,
                      fontWeight: 600,
                      letterSpacing: 0),
                  Spacing.height(8),
                  FxText.caption("at 15 - 25 March 2021",
                      color: _theme.colorScheme.onBackground.withAlpha(100),
                      fontWeight: 500,
                      letterSpacing: -0.2),
                ],
              ),
            ],
          ),
        ),
        Spacing.height(24),
        Paragraph(
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
        Spacing.height(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: buildCategories(),
            // children: (() {
            //   List<Widget> children = [];
            //   children.add(Spacing.width(24));

            //   for (int i = 0; i < _categories.length; i++) {
            //     children.add(_getCategoryHero(_categories[i]));
            //     children.add(Spacing.width(16));
            //   }

            //   return children;
            // }()),
          ),
        ),
        Spacing.height(24),
        Paragraph(
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
        Spacing.height(16),
        Padding(
          padding: Spacing.horizontal(24),
          child: Column(
            children: _products.map((e) => _getProductScreen(e)).toList(),
          ),
        )
      ],
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

  static String randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  Widget getSingleCategory(Category category) {
    String heroTag = randomString(10);

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

  Widget _getCategoryHero(Category category) {
    return Hero(
      tag: category.image,
      child: Card(
        onTap: () {
          Navigator.push(
              widget.rootContext,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => GroceryCategoryScreen(
                      context, category, category.image)));
        },
        width: 80,
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

  Widget _getProductScreen(Product product) {
    return Card(
      onTap: () {
        Navigator.push(
            widget.rootContext,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    GrocerySingleProductScreen(product, product.name)));
      },
      margin: Spacing.bottom(16),
      child: Card(
        padding: Spacing.all(16),
        background: _theme.primaryColor.withAlpha(32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              background: _theme.primaryColor.withAlpha(32),
              padding: Spacing.all(8),
              child: Hero(
                tag: product.name,
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
                            FxText.caption(
                                "\$" +
                                    product.price.toStringAsFixed(
                                        product.price.truncateToDouble() ==
                                                product.price
                                            ? 0
                                            : 1),
                                decoration: TextDecoration.lineThrough,
                                fontWeight: 500),
                            Spacing.width(8),
                            FxText.b2(
                                "\$" +
                                    product.discountedPrice.toStringAsFixed(
                                        product.discountedPrice
                                                    .truncateToDouble() ==
                                                product.discountedPrice
                                            ? 0
                                            : 1),
                                color: _theme.colorScheme.onBackground,
                                fontWeight: 700),
                          ],
                        )
                      : FxText.b2(
                          "\$" +
                              product.price.toStringAsFixed(
                                  product.price.truncateToDouble() ==
                                          product.price
                                      ? 0
                                      : 1),
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
