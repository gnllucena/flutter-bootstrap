import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:zerodezenove/src/configurations/writing.dart';
import 'package:zerodezenove/src/widgets/FX/button/button.dart';
import 'package:zerodezenove/src/widgets/FX/container/container.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationDialog extends StatefulWidget {
  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Style.getThemeData().copyWith(
          colorScheme: Style.getThemeData().colorScheme.copyWith(
              secondary:
                  Style.getThemeData().colorScheme.primary.withAlpha(80))),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.sh1("Notification", fontWeight: 600),
          actions: <Widget>[
            Container(
              margin: Spacing.right(16),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  MdiIcons.notificationClearAll,
                  size: 24,
                  color: Style.getThemeData().colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
        body: ListView(
          padding: Spacing.all(16),
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FxText.b1(
                    "Offers",
                    fontWeight: 600,
                  ),
                  FxContainer.rounded(
                    margin: Spacing.left(8),
                    width: 18,
                    paddingAll: 0,
                    height: 18,
                    background: Style.getThemeData().primaryColor.withAlpha(40),
                    child: Center(
                        child: FxText.overline(
                      "2",
                      fontWeight: 600,
                      color: Style.getThemeData().primaryColor,
                    )),
                  )
                ],
              ),
            ),
            Spacing.height(24),
            singleNotification(
                image: './assets/images/apps/grocery/product-5.png',
                text: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "50% OFF ",
                        style: Writing.button(
                            color: Style.getThemeData().primaryColor,
                            fontWeight: 600,
                            letterSpacing: 0.2)),
                    TextSpan(
                      text: "in ultraboost all puma ltd shoes",
                      style: Writing.button(
                          color: Style.getThemeData().colorScheme.onBackground,
                          fontWeight: 500,
                          letterSpacing: 0.2),
                    )
                  ]),
                ),
                time: "9:35 AM"),
            Spacing.height(24),
            singleNotification(
                image: './assets/images/apps/grocery/product-2.png',
                text: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "30% OFF ",
                        style: Writing.button(
                            color: Style.getThemeData().primaryColor,
                            fontWeight: 600,
                            letterSpacing: 0.2)),
                    TextSpan(
                        text: "in all cake till 31 july",
                        style: Writing.button(
                            color:
                                Style.getThemeData().colorScheme.onBackground,
                            fontWeight: 500,
                            letterSpacing: 0.2))
                  ]),
                ),
                time: "9:35 AM"),
            Spacing.height(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FxText.b1(
                  "Orders",
                  fontWeight: 600,
                ),
                FxContainer.rounded(
                  margin: Spacing.left(8),
                  width: 18,
                  paddingAll: 0,
                  height: 18,
                  background: Style.getThemeData().primaryColor.withAlpha(40),
                  child: Center(
                      child: FxText.overline(
                    "8",
                    fontWeight: 600,
                    color: Style.getThemeData().primaryColor,
                  )),
                )
              ],
            ),
            Spacing.height(24),
            singleNotification(
                image: './assets/images/apps/grocery/product-3.png',
                text: FxText.button(
                    "Your cake order has been delivered at Himalaya",
                    color: Style.getThemeData().colorScheme.onBackground,
                    fontWeight: 500,
                    letterSpacing: 0),
                time: "Just Now"),
            Spacing.height(24),
            singleNotification(
                image: './assets/images/apps/grocery/product-2.png',
                text: FxText.button("last order has been cancelled by seller",
                    color: Style.getThemeData().colorScheme.onBackground,
                    fontWeight: 500,
                    letterSpacing: 0),
                time: "14 July"),
            Spacing.height(24),
            Center(
              child: FxButton.text(
                splashColor: Style.getThemeData().primaryColor.withAlpha(40),
                child: FxText.button("View all",
                    color: Style.getThemeData().primaryColor,
                    fontWeight: 600,
                    letterSpacing: 0.2),
                onPressed: () {},
              ),
            ),
            Spacing.height(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FxText.b1(
                  "Security",
                  fontWeight: 600,
                ),
                FxContainer.rounded(
                  margin: Spacing.left(8),
                  width: 18,
                  paddingAll: 0,
                  height: 18,
                  background: Style.getThemeData().primaryColor.withAlpha(40),
                  child: Center(
                      child: FxText.overline(
                    "1",
                    fontWeight: 600,
                    color: Style.getThemeData().primaryColor,
                  )),
                )
              ],
            ),
            Spacing.height(24),
            singleNotification(
                image: './assets/images/apps/grocery/profile.png',
                text: FxText.button("Your account password has been changed",
                    color: Style.getThemeData().colorScheme.onBackground,
                    fontWeight: 500,
                    letterSpacing: 0),
                time: "2 days ago"),
          ],
        ),
      ),
    );
  }

  Widget singleNotification(
      {required String image, Widget? text, required String time}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FxContainer.rounded(
            width: 52,
            height: 52,
            padding: Spacing.all(10),
            background: Style.getThemeData().primaryColor.withAlpha(40),
            child: Image.asset(image),
          ),
          Expanded(
            child: Container(margin: Spacing.horizontal(16), child: text),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FxText.caption(time,
                  muted: true, fontWeight: 500, letterSpacing: -0.2),
            ],
          )
        ],
      ),
    );
  }
}
