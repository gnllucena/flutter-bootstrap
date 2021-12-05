import 'dart:math';
import 'dart:ui';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/configurations/writing.dart';
import 'package:zerodezenove/domain/product.dart';
import 'package:zerodezenove/widgets/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'single_product_screen.dart';

class GrocerySearchScreen extends StatefulWidget {
  final BuildContext rootContext;

  const GrocerySearchScreen({Key? key, required this.rootContext})
      : super(key: key);

  @override
  _GrocerySearchScreenState createState() => _GrocerySearchScreenState();
}

class _GrocerySearchScreenState extends State<GrocerySearchScreen>
    with SingleTickerProviderStateMixin {
  late List<Product> products;

  @override
  initState() {
    super.initState();
    products = Product.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: Spacing.fromLTRB(24, 48, 24, 70),
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: FxTextField(
                      hintText: "Search",
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        size: 18,
                        color: Style.getThemeData()
                            .colorScheme
                            .onBackground
                            .withAlpha(150),
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: CustomStyle.getThemeData().card,
                      hintStyle: Writing.b2(),
                      labelStyle: Writing.b2(),
                      style: Writing.b2(),
                      textCapitalization: TextCapitalization.sentences,
                      labelText: "Search",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      cursorColor: Style.getThemeData().primaryColor,
                      focusedBorderColor: Colors.transparent,
                    ),
                  ),
                  Spacing.width(16),
                  //Space.width(16),
                  FxContainer(
                    background: Style.getThemeData().primaryColor.withAlpha(32),
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: Icon(
                        FeatherIcons.sliders,
                        color: Style.getThemeData().primaryColor,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacing.height(24),
            FxText.b2("Search for Vegetables",
                letterSpacing: 0, fontWeight: 600),
            Spacing.height(16),
            Column(
              children: buildProducts(),
            )
          ],
        ));
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
        background: CustomStyle.getThemeData().card,
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
