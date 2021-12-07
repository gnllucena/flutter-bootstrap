import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart' hide Typography, Card;
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zerodezenove/src/todo-screens/single_product_screen.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';
import 'package:zerodezenove/src/widgets/card/card.dart';
import 'package:zerodezenove/src/widgets/paragraph/paragraph.dart';
import 'package:zerodezenove/src/widgets/screen/screen.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/configurations/typography.dart';
import 'package:zerodezenove/src/domain/product.dart';
import 'package:zerodezenove/src/widgets/FX/text_field/text_field.dart';

class GrocerySearchScreen extends StatefulWidget {
  final BuildContext rootContext;

  const GrocerySearchScreen({Key? key, required this.rootContext})
      : super(key: key);

  @override
  _GrocerySearchScreenState createState() => _GrocerySearchScreenState();
}

class _GrocerySearchScreenState extends State<GrocerySearchScreen>
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
    return Screen(children: [
      Paragraph(
        children: [
          FxText.h6(
            "Search",
            color: _theme.colorScheme.onBackground,
            fontWeight: 600,
          )
        ],
      ),
      Spacing.height(16),
      Card(
        padding: Spacing.horizontal(24),
        child: Row(
          children: [
            Expanded(
              child: FxTextField(
                hintText: "Search",
                prefixIcon: Icon(
                  FeatherIcons.search,
                  size: 18,
                  color: _theme.colorScheme.onBackground.withAlpha(150),
                ),
                filled: true,
                isDense: true,
                fillColor: CustomStyle.getThemeData().card,
                hintStyle: Typography.b2(),
                labelStyle: Typography.b2(),
                style: Typography.b2(),
                textCapitalization: TextCapitalization.sentences,
                labelText: "Search",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                cursorColor: _theme.primaryColor,
                focusedBorderColor: Colors.transparent,
              ),
            )
          ],
        ),
      ),
      Spacing.height(16),
      Paragraph(
        children: [
          FxText.b2("Search for Vegetables", letterSpacing: 0, fontWeight: 600)
        ],
      ),
      Spacing.height(16),
      Card(
        padding: Spacing.horizontal(24),
        child: Column(
          children: _products.map((e) => _getProductWidget(e)).toList(),
        ),
      ),
    ]);
  }

  Widget _getProductWidget(Product product) {
    return Card(
      onTap: () {
        Navigator.push(
            widget.rootContext,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    GrocerySingleProductScreen(product)));
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
