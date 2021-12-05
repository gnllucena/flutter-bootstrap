import 'dart:math';
import 'dart:ui';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/skin.dart';
import 'package:zerodezenove/domain/category.dart';
import 'package:zerodezenove/domain/product.dart';
import 'package:zerodezenove/screens/single_product_screen.dart';
import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroceryCategoryScreen extends StatefulWidget {
  final BuildContext rootContext;
  final Category category;
  final String heroTag;

  const GroceryCategoryScreen(this.rootContext, this.category, this.heroTag);

  @override
  _GroceryCategoryScreenState createState() => _GroceryCategoryScreenState();
}

class _GroceryCategoryScreenState extends State<GroceryCategoryScreen>
    with SingleTickerProviderStateMixin {
  late List<Product> products;

  @override
  initState() {
    super.initState();
    products = Product.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Skin.getTheme().copyWith(
          colorScheme: Skin.getTheme()
              .colorScheme
              .copyWith(secondary: Skin.getTheme().primaryColor)),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                MdiIcons.chevronLeft,
                color: Skin.getTheme().colorScheme.onBackground,
              ),
            ),
          ),
          body: ListView(
            padding: Spacing.fromLTRB(24, 0, 24, 0),
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Hero(
                      tag: widget.heroTag,
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
                      color: Skin.getTheme().colorScheme.onBackground,
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
          )),
    );
  }

  List<Widget> buildProducts() {
    List<Widget> list = [];
    for (Product product in products) {
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
                    GrocerySingleProductScreen(product, heroKey)));
      },
      child: FxContainer(
        margin: Spacing.bottom(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              background: Skin.getTheme().primaryColor.withAlpha(32),
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
                      color: Skin.getTheme().colorScheme.onBackground,
                      fontWeight: 600),
                  Spacing.height(8),
                  FxText.overline(product.description,
                      color: Skin.getTheme().colorScheme.onBackground,
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
                                color: Skin.getTheme().colorScheme.onBackground,
                                fontWeight: 700),
                          ],
                        )
                      : FxText.b2("\$" + doubleToString(product.price),
                          color: Skin.getTheme().colorScheme.onBackground,
                          fontWeight: 700),
                ],
              ),
            ),
            // Space.width(8),
            Icon(
              MdiIcons.heartOutline,
              color: Skin.getTheme().primaryColor,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
