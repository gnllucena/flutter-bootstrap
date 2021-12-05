import 'dart:math';
import 'dart:ui';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/configurations/writing.dart';
import 'package:zerodezenove/domain/cart.dart';
import 'package:zerodezenove/screens/checkout_screen.dart';
import 'package:zerodezenove/screens/coupon_screen.dart';
import 'package:zerodezenove/widgets/button/button.dart';
import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/dashed_divider/dashed_divider.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:zerodezenove/widgets/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroceryCartScreen extends StatefulWidget {
  final BuildContext rootContext;

  const GroceryCartScreen({Key? key, required this.rootContext})
      : super(key: key);

  @override
  _GroceryCartScreenState createState() => _GroceryCartScreenState();
}

class _GroceryCartScreenState extends State<GroceryCartScreen>
    with SingleTickerProviderStateMixin {
  late List<Cart> carts;

  @override
  initState() {
    super.initState();
    carts = Cart.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: FxText.sh1("Cart", fontWeight: 600),
        ),
        body: ListView(
          padding: Spacing.fromLTRB(24, 8, 24, 70),
          children: <Widget>[
            Column(
              children: buildCarts(),
            ),
            Spacing.height(16),
            FxContainer(
              background: CustomStyle.getTheme().card,
              padding: Spacing.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: FxTextField(
                      hintText: "Promo Code",
                      hintStyle: Writing.b2(),
                      labelStyle: Writing.b2(),
                      style: Writing.b2(),
                      labelText: "Promo Code",
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: Spacing.right(16),
                      focusedBorderColor: Colors.transparent,
                      cursorColor: Style.getTheme().primaryColor,
                      prefixIcon: Icon(
                        MdiIcons.ticketPercentOutline,
                        size: 22,
                        color: Style.getTheme()
                            .colorScheme
                            .onBackground
                            .withAlpha(150),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  FxButton.medium(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroceryCouponScreen()));
                    },
                    child: FxText.button("Find",
                        letterSpacing: 0.5,
                        fontWeight: 600,
                        color: Style.getTheme().backgroundColor),
                    backgroundColor: Style.getTheme().primaryColor,
                    borderRadiusAll: 4,
                    padding: Spacing.xy(32, 12),
                    elevation: 0,
                  ),
                ],
              ),
            ),
            Spacing.height(16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.b2("Subtotal", fontWeight: 600),
                    FxText.b2("\$86.50", letterSpacing: 0.25, fontWeight: 600),
                  ],
                ),
                Spacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.b2("Delivery", fontWeight: 600),
                    FxText.b2("\$18.50", letterSpacing: 0.25, fontWeight: 600),
                  ],
                ),
                Spacing.height(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.b2("Tax & Fee", fontWeight: 600),
                    FxText.b2("\$9.99", letterSpacing: 0.25, fontWeight: 600),
                  ],
                ),
                Spacing.height(12),
                FxDashedDivider(
                  dashSpace: 6,
                  height: 1.2,
                  dashWidth: 8,
                  color: Style.getTheme().colorScheme.onBackground,
                ),
                Spacing.height(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.b1("Total", fontWeight: 700),
                    FxText.b1("\$99.50", letterSpacing: 0.25, fontWeight: 700),
                  ],
                ),
              ],
            ),
            Spacing.height(24),
            Center(
              child: FxButton.medium(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroceryCheckoutScreen()));
                },
                child: FxText.button(
                  "CHECKOUT",
                  letterSpacing: 0.5,
                  fontWeight: 600,
                  color: Style.getTheme().backgroundColor,
                ),
                backgroundColor: Style.getTheme().primaryColor,
                borderRadiusAll: 4,
                padding: Spacing.xy(32, 12),
                elevation: 0,
              ),
            )
          ],
        ));
  }

  List<Widget> buildCarts() {
    List<Widget> list = [];

    for (int i = 0; i < carts.length; i++) {
      list.add(SingleCartWidget(context, carts[i]));
      if (i + 1 < carts.length) list.add(Spacing.height(16));
    }

    return list;
  }
}

class SingleCartWidget extends StatefulWidget {
  final BuildContext rootContext;
  final Cart cart;

  const SingleCartWidget(this.rootContext, this.cart);

  @override
  _SingleCartWidgetState createState() => _SingleCartWidgetState();
}

class _SingleCartWidgetState extends State<SingleCartWidget> {
  late int quantity;
  late BuildContext rootContext;

  String? heroKey;

  @override
  void initState() {
    super.initState();
    quantity = widget.cart.quantity;
    rootContext = widget.rootContext;
    heroKey = randomString(10);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: CustomStyle.getTheme().card,
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
              color: CustomStyle.getTheme().cardDark,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: Spacing.horizontal(20),
          alignment: AlignmentDirectional.centerEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: Spacing.right(8),
                padding: Spacing.all(16),
                decoration: BoxDecoration(
                    color: CustomStyle.red.withAlpha(40),
                    shape: BoxShape.circle),
                child: Icon(
                  FeatherIcons.trash,
                  size: 22,
                  color: CustomStyle.red,
                ),
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            setState(() {
              //TODO: perform delete operation
            });
          }
        },
        child: FxContainer(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxContainer(
                background: Style.getTheme().primaryColor.withAlpha(32),
                padding: Spacing.all(8),
                child: Hero(
                  tag: heroKey!,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.cart.image,
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
                    FxText.b1(widget.cart.name, fontWeight: 600),
                    Spacing.height(8),
                    widget.cart.discountedPrice != widget.cart.price
                        ? Row(
                            children: [
                              FxText.caption(
                                  "\$" + doubleToString(widget.cart.price),
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: 500),
                              // Space.width(8),
                              Spacing.width(8),
                              FxText.b2(
                                  "\$" +
                                      doubleToString(
                                          widget.cart.discountedPrice),
                                  color:
                                      Style.getTheme().colorScheme.onBackground,
                                  fontWeight: 700),
                            ],
                          )
                        : FxText.b2("\$" + doubleToString(widget.cart.price),
                            color: Style.getTheme().colorScheme.onBackground,
                            fontWeight: 700),
                    Spacing.height(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FxContainer(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                          paddingAll: 8,
                          borderRadiusAll: 4,
                          background:
                              Style.getTheme().primaryColor.withAlpha(48),
                          child: Icon(
                            MdiIcons.minus,
                            size: 14,
                            color: Style.getTheme().primaryColor,
                          ),
                        ),
                        Spacing.width(12),
                        FxText.b1(quantity.toString(), fontWeight: 600),
                        Spacing.width(12),
                        FxContainer(
                          padding: Spacing.all(8),
                          borderRadiusAll: 4,
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          background: Style.getTheme().primaryColor,
                          child: Icon(
                            MdiIcons.plus,
                            size: 14,
                            color: Style.getTheme().backgroundColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
