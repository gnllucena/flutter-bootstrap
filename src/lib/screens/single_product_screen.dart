import 'dart:math';
import 'dart:ui';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/skin.dart';
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
      data: Skin.getTheme().copyWith(
          colorScheme: Skin.getTheme().colorScheme.copyWith(
              secondary: Skin.getTheme().colorScheme.primary.withAlpha(80))),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                MdiIcons.chevronLeft,
                color: Skin.getTheme().primaryColor,
                size: 20,
              ),
            ),
            actions: [
              Icon(
                MdiIcons.heartOutline,
                color: Skin.getTheme().primaryColor,
                size: 20,
              ),
              Spacing.width(16)
            ],
          ),
          body: Container(
            color: Skin.getTheme().primaryColor.withAlpha(68),
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
                  background: CustomSkin.getTheme().card,
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
                                Skin.getTheme().primaryColor.withAlpha(40),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FxText.b2("(243 review)",
                                    color: Skin.getTheme().primaryColor,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                Icon(
                                  MdiIcons.chevronRight,
                                  size: 14,
                                  color: Skin.getTheme().primaryColor,
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
                                background:
                                    Skin.getTheme().primaryColor.withAlpha(48),
                                child: Icon(
                                  MdiIcons.minus,
                                  size: 14,
                                  color: Skin.getTheme().primaryColor,
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
                                background: Skin.getTheme().primaryColor,
                                child: Icon(
                                  MdiIcons.plus,
                                  size: 14,
                                  color: Skin.getTheme().backgroundColor,
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
                                color: Skin.getTheme().backgroundColor),
                            backgroundColor: Skin.getTheme().primaryColor,
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
