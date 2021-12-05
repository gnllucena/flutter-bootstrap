import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/widgets/FX/container/container.dart';
import 'package:zerodezenove/widgets/FX/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroceryOrderScreen extends StatefulWidget {
  @override
  _GroceryOrderScreenState createState() => _GroceryOrderScreenState();
}

class _GroceryOrderScreenState extends State<GroceryOrderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Style.getThemeData().copyWith(
          colorScheme: Style.getThemeData().colorScheme.copyWith(
              secondary:
                  Style.getThemeData().colorScheme.primary.withAlpha(80))),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                MdiIcons.chevronLeft,
                color: Style.getThemeData().colorScheme.onBackground,
              ),
            ),
            title: FxText.sh1("Orders", fontWeight: 600),
          ),
          body: Container(
            child: ListView(
              padding: Spacing.fromLTRB(24, 8, 24, 0),
              children: [
                singleOrderItem(
                    price: 49.49,
                    time: "12 April 2020, 1:45",
                    listItem: [
                      "./assets/images/apps/grocery/product-1.png",
                      "./assets/images/apps/grocery/product-2.png",
                      "./assets/images/apps/grocery/product-3.png",
                      "./assets/images/apps/grocery/product-4.png",
                    ],
                    number: 4568,
                    status: "In Progress"),
                singleOrderItem(
                    price: 54.99,
                    time: "14 Feb 2020, 12:04",
                    listItem: [
                      "./assets/images/apps/grocery/product-5.png",
                      "./assets/images/apps/grocery/product-3.png",
                    ],
                    number: 1478,
                    status: "Delivered"),
                singleOrderItem(
                    price: 69.99,
                    time: "16 Dec 2019, 8:48",
                    listItem: [
                      "./assets/images/apps/grocery/product-4.png",
                      "./assets/images/apps/grocery/product-1.png",
                      "./assets/images/apps/grocery/product-2.png",
                    ],
                    number: 1123,
                    status: "Delivered"),
              ],
            ),
          )),
    );
  }

  Widget singleOrderItem(
      {required List<String> listItem,
      int? number,
      String? time,
      String? status,
      double? price}) {
    //Logic for row items
    double space = 16;

    List<Widget> _itemWidget = [];
    for (int i = 0; i < listItem.length; i++) {
      if (i == 2 && listItem.length > 3) {
        _itemWidget.add(
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              color: Style.getThemeData().primaryColor.withAlpha(40),
              height: 80,
              width: 80,
              child: Center(
                  child: FxText.sh1("+" + (listItem.length - 2).toString(),
                      letterSpacing: 0.5,
                      color: Style.getThemeData().primaryColor,
                      fontWeight: 600)),
            ),
          ),
        );
        break;
      } else {
        _itemWidget.add(
          FxContainer(
            margin: (i == 2) ? Spacing.zero : Spacing.right(space),
            padding: Spacing.all(12),
            background: Style.getThemeData().primaryColor.withAlpha(40),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                listItem[i],
                height: 56,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }
    }

    return FxContainer(
      padding: Spacing.all(16),
      margin: Spacing.bottom(16),
      background: CustomStyle.getThemeData().card,
      bordered: true,
      border: Border.all(color: CustomStyle.getThemeData().border, width: 1.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FxText.b1("Order $number",
                        fontWeight: 600, letterSpacing: -0.2),
                    Spacing.height(4),
                    FxText.b2(
                      "\$ $price",
                      fontWeight: 600,
                    ),
                  ],
                ),
              ),
              FxContainer(
                padding: Spacing.fromLTRB(12, 8, 12, 8),
                background: CustomStyle.getThemeData().card,
                borderRadiusAll: 4,
                child: FxText.overline(status!.toUpperCase(),
                    fontWeight: 700, letterSpacing: 0.2),
              )
            ],
          ),
          Spacing.height(16),
          FxText.caption(
            time!,
            muted: true,
          ),
          Spacing.height(16),
          Wrap(
            children: _itemWidget,
          ),
        ],
      ),
    );
  }
}
