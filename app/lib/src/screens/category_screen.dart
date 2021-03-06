import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zerodezenove/src/widgets/card/card.dart';
import 'package:zerodezenove/src/widgets/screen/screen.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/domain/category.dart';
import 'package:zerodezenove/src/domain/product.dart';
import 'package:zerodezenove/src/todo-screens/single_product_screen.dart';
import 'package:zerodezenove/src/widgets/FX/container/container.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';

class CategoryScreen extends StatefulWidget {
  final BuildContext rootContext;
  final Category category;

  const CategoryScreen(this.rootContext, this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late List<Product> _products;
  late ThemeData _theme;

  @override
  initState() {
    super.initState();
    _products = Product.getList();
    _theme = Style.getThemeData();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Screen(
      padding: Spacing.fromLTRB(24, 0, 24, 0),
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            MdiIcons.chevronLeft,
            color: _theme.colorScheme.onBackground,
          ),
        ),
      ),
      children: <Widget>[
        Card(
          child: Column(
            children: [
              Hero(
                tag: "category-category" + widget.category.title,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.category.color,
                  ),
                  padding: Spacing.all(20),
                  child: Image.asset(
                    widget.category.image,
                    width: 52,
                    height: 52,
                  ),
                ),
              ),
              Spacing.height(16),
              FxText.sh1(
                widget.category.title,
                color: Style.getThemeData().colorScheme.onBackground,
                fontWeight: 600,
              )
            ],
          ),
        ),
        Spacing.height(24),
        Column(
          children: buildProducts(),
        )
      ],
    );
  }

  List<Widget> buildProducts() {
    List<Widget> list = [];
    for (Product product in _products) {
      list.add(getSingleProduct(product));
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

  static String doubleToString(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  Widget getSingleProduct(Product product) {
    String heroKey = randomString(10);

    return InkWell(
      onTap: () {
        Navigator.push(
            widget.rootContext,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    GrocerySingleProductScreen(product)));
      },
      child: FxContainer(
        margin: Spacing.bottom(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              background: Style.getThemeData().primaryColor.withAlpha(32),
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
                      color: Style.getThemeData().colorScheme.onBackground,
                      fontWeight: 600),
                  Spacing.height(8),
                  FxText.overline(product.description,
                      color: Style.getThemeData().colorScheme.onBackground,
                      muted: true),
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
                                color: Style.getThemeData()
                                    .colorScheme
                                    .onBackground,
                                fontWeight: 700),
                          ],
                        )
                      : FxText.b2("\$" + doubleToString(product.price),
                          color: Style.getThemeData().colorScheme.onBackground,
                          fontWeight: 700),
                ],
              ),
            ),
            // Space.width(8),
            Icon(
              MdiIcons.heartOutline,
              color: Style.getThemeData().primaryColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
