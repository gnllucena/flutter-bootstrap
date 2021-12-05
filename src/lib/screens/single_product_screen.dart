import 'dart:math';
import 'dart:ui';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/domain/product.dart';
import 'package:zerodezenove/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'checkout_screen.dart';
import 'product_review_screen.dart';

class GrocerySingleProductScreen extends StatefulWidget {
  final String heroKey;
  final Product product;

  const GrocerySingleProductScreen(this.product, this.heroKey);

  @override
  _GrocerySingleProductScreenState createState() =>
      _GrocerySingleProductScreenState();
}

class _GrocerySingleProductScreenState extends State<GrocerySingleProductScreen>
    with SingleTickerProviderStateMixin {
  late List<Product> products;
  int quantity = 1;

  @override
  initState() {
    super.initState();
    products = Product.getList();
  }

  Widget build(BuildContext context) {
    return Theme(
      data: Style.getThemeData().copyWith(
          colorScheme: Style.getThemeData().colorScheme.copyWith(
              secondary:
                  Style.getThemeData().colorScheme.primary.withAlpha(80))),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                MdiIcons.chevronLeft,
                color: Style.getThemeData().primaryColor,
                size: 20,
              ),
            ),
            actions: [
              Icon(
                MdiIcons.heartOutline,
                color: Style.getThemeData().primaryColor,
                size: 20,
              ),
              Spacing.width(16)
            ],
          ),
          body: Container(
            color: Style.getThemeData().primaryColor.withAlpha(68),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Hero(
                    tag: widget.heroKey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Spacing.height(24),
                FxContainer(
                  padding: Spacing.all(24),
                  background: CustomStyle.getThemeData().card,
                  borderRadiusAll: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.sh1(widget.product.name,
                                    fontWeight: 700),
                                Spacing.height(8),
                                Row(
                                  children: [
                                    FxText.caption(
                                      "\$3.99",
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                    Spacing.width(8),
                                    // Space.width(8),
                                    FxText.b2(
                                      "\$2.32",
                                      fontWeight: 600,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          FxContainer(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GroceryProductReviewScreen()));
                            },
                            padding: Spacing.fromLTRB(8, 6, 8, 6),
                            background:
                                Style.getThemeData().primaryColor.withAlpha(40),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FxText.b2("(243 review)",
                                    color: Style.getThemeData().primaryColor,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                Icon(
                                  MdiIcons.chevronRight,
                                  size: 14,
                                  color: Style.getThemeData().primaryColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacing.height(4),
                      FxText.caption(widget.product.description,
                          letterSpacing: 0.4, fontWeight: 500, muted: true),
                      Spacing.height(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FxContainer(
                                borderRadiusAll: 4,
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                                padding: Spacing.all(6),
                                background: Style.getThemeData()
                                    .primaryColor
                                    .withAlpha(48),
                                child: Icon(
                                  MdiIcons.minus,
                                  size: 14,
                                  color: Style.getThemeData().primaryColor,
                                ),
                              ),
                              Spacing.width(12),
                              FxText.b1(quantity.toString(), fontWeight: 600),
                              Spacing.width(12),
                              FxContainer(
                                borderRadiusAll: 4,
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                padding: Spacing.all(6),
                                background: Style.getThemeData().primaryColor,
                                child: Icon(
                                  MdiIcons.plus,
                                  size: 14,
                                  color: Style.getThemeData().backgroundColor,
                                ),
                              ),
                            ],
                          ),
                          Spacing.width(24),
                          Expanded(
                              child: FxButton(
                            borderRadiusAll: 4,
                            elevation: 0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GroceryCheckoutScreen()));
                            },
                            child: FxText.b2("Buy Now",
                                fontWeight: 600,
                                color: Style.getThemeData().backgroundColor),
                            backgroundColor: Style.getThemeData().primaryColor,
                          ))
                        ],
                      ),
                      Spacing.height(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.sh1("Related", fontWeight: 600),
                          FxText.caption("See All",
                              fontWeight: 600, xMuted: true, letterSpacing: 0),
                        ],
                      ),
                      Spacing.height(16),
                      Column(
                        children: buildProducts(),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
            context,
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
