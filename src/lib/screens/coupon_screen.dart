import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/skin.dart';
import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/dotted_line/dotted_line.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroceryCouponScreen extends StatefulWidget {
  @override
  _GroceryCouponScreenState createState() => _GroceryCouponScreenState();
}

class _GroceryCouponScreenState extends State<GroceryCouponScreen> {
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
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                MdiIcons.chevronLeft,
                size: 20,
              ),
            ),
            title: FxText.sh1("Coupons", fontWeight: 600),
          ),
          body: Container(
            child: ListView(
              padding: Spacing.fromLTRB(24, 8, 24, 0),
              children: <Widget>[
                singleCoupon(MdiIcons.skype, CustomSkin.blue, "Skype", "Shoes",
                    80, "VIABILITY50"),
                // Space.height(24),
                singleCoupon(MdiIcons.spotify, CustomSkin.green, "Spotify",
                    "Songs", 30, "SPOTIFY70"),
                // Space.height(24),
                singleCoupon(MdiIcons.cart, CustomSkin.purple, "Cart", "Shop",
                    60, "CART30"),
                // Space.height(24),
                singleCoupon(MdiIcons.sonyPlaystation, CustomSkin.orange,
                    "Sony", "PS5", 35, "SPS35"),
              ],
            ),
          )),
    );
  }

  Widget singleCoupon(IconData iconData, Color color, String company,
      String product, int offer, String code) {
    return FxContainer(
      margin: Spacing.bottom(16),
      padding: Spacing.all(16),
      background: CustomSkin.getTheme().card,
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: Spacing.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: color.withAlpha(200)),
                child: Icon(
                  iconData,
                  color: Skin.getTheme().backgroundColor,
                ),
              ),
              Spacing.height(8),
              FxText.b1(company, fontWeight: 600),
              Spacing.height(4),
              FxText.caption(
                product,
                fontWeight: 500,
                muted: true,
              ),
            ],
          ),
          Spacing.width(16),
          FxDottedLine(
            color: Skin.getTheme().colorScheme.onBackground.withAlpha(100),
            height: 100,
            strokeWidth: 1.2,
            dottedLength: 8,
            space: 4,
          ),
          Spacing.width(16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FxText.h6(offer.toString() + "%", fontWeight: 700),
                  FxText.b2("off", fontWeight: 600, xMuted: true),
                ],
              ),
              Spacing.height(24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FxText.caption("Promo code:",
                      xMuted: true, letterSpacing: -0.2),
                  Spacing.width(8),
                  FxContainer(
                    padding: Spacing.fromLTRB(12, 8, 12, 8),
                    borderRadiusAll: 4,
                    background: Skin.getTheme().primaryColor.withAlpha(40),
                    child: FxText.caption(
                      code,
                      letterSpacing: 0,
                      fontWeight: 600,
                      color: Skin.getTheme().primaryColor,
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
