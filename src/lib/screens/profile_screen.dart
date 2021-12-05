import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/skin.dart';

import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:flutter/rendering.dart';

import 'order_screen.dart';

class GroceryProfileScreen extends StatefulWidget {
  final BuildContext rootContext;

  const GroceryProfileScreen({Key? key, required this.rootContext})
      : super(key: key);

  @override
  _GroceryProfileScreenState createState() => _GroceryProfileScreenState();
}

class _GroceryProfileScreenState extends State<GroceryProfileScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: Spacing.fromLTRB(24, 72, 24, 70),
          children: [
            Center(
              child: FxContainer.rounded(
                padding: Spacing.all(20),
                background: Skin.getTheme().primaryColor.withAlpha(40),
                child: Image.asset(
                  'assets/images/apps/grocery/profile.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Spacing.height(16),
            Center(
              child: FxText.b1("Kelvin Gonzalez", fontWeight: 600),
            ),
            Spacing.height(32),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroceryOrderScreen()));
                },
                child: getSingleSetting(
                    iconData: FeatherIcons.shoppingBag,
                    color: CustomSkin.brown,
                    title: "My Orders")),
            getSingleSetting(
                iconData: FeatherIcons.creditCard,
                color: CustomSkin.green,
                title: "Wallet"),
            getSingleSetting(
                iconData: FeatherIcons.tag,
                color: CustomSkin.purple,
                title: "Vouchers"),
            getSingleSetting(
                iconData: FeatherIcons.mapPin,
                color: CustomSkin.orange,
                title: "My Address"),
            getSingleSetting(
                iconData: FeatherIcons.logOut,
                color: CustomSkin.red,
                title: "Log Out"),
          ],
        ));
  }

  Widget getSingleSetting(
      {IconData? iconData, required Color color, required String title}) {
    return Container(
      margin: Spacing.bottom(16),
      child: Row(
        children: [
          FxContainer(
            background: color.withAlpha(24),
            child: Icon(
              iconData,
              color: color,
              size: 22,
            ),
          ),
          Spacing.width(24),
          FxText.b1(title, letterSpacing: 0.3, fontWeight: 600)
        ],
      ),
    );
  }
}
