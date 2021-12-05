import 'dart:math';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/style.dart';
import 'package:zerodezenove/widgets/container/container.dart';
import 'package:zerodezenove/widgets/star_rating/star_rating.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroceryProductReviewScreen extends StatefulWidget {
  @override
  _GroceryProductReviewScreenState createState() =>
      _GroceryProductReviewScreenState();
}

class _GroceryProductReviewScreenState extends State<GroceryProductReviewScreen>
    with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Style.getTheme().copyWith(
          colorScheme: Style.getTheme().colorScheme.copyWith(
              secondary: Style.getTheme().colorScheme.primary.withAlpha(80))),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                MdiIcons.chevronLeft,
                size: 20,
                color: Style.getTheme().colorScheme.onBackground,
              ),
            ),
            title: FxText("Reviews", fontWeight: 600),
          ),
          body: ListView(
            padding: Spacing.fromLTRB(24, 8, 24, 0),
            children: <Widget>[
              _buildRatingWidget(),
              Spacing.height(24),
              _singleReview(
                  image: "./assets/images/profile/avatar-4.jpg",
                  name: "Tegan Payne",
                  rating: 5,
                  review: getDummyText(32),
                  time: "1 day ago"),
              _singleReview(
                  image: "./assets/images/profile/avatar-3.jpg",
                  name: "Jamal Rossi",
                  rating: 4,
                  review: getDummyText(25),
                  time: "7 days ago"),
              _singleReview(
                  image: "./assets/images/profile/avatar-2.jpg",
                  name: "Harvie Duncan",
                  rating: 4,
                  review: getDummyText(30),
                  time: "1 month ago"),
              // Space.height(8),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: FxText.b2("Write a Review",
                      letterSpacing: 0,
                      color: Style.getTheme().primaryColor,
                      fontWeight: 600),
                ),
              )
            ],
          )),
    );
  }

  static List<Color> getColorByRating() {
    return [
      Color(0xfff0323c), //For 0 star color
      Color(0xfff0323c), //For 1 star color
      Color(0xfff0323c).withAlpha(200), //For 2 star color
      Color(0xfff9c700), //For 3 star color
      Color(0xff3cd278).withAlpha(200), //For 4 star color
      Color(0xff3cd278) //For 5 star color
    ];
  }

  static const String _dummyText =
      "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc";

  static String getDummyText(int words, {withStop = true}) {
    var rand = new Random();
    List<String> dummyTexts = _dummyText.split(" ");

    int size = dummyTexts.length;
    String text = "";
    String firstWord = dummyTexts[rand.nextInt(size)];
    firstWord = firstWord[0].toUpperCase() + firstWord.substring(1);
    text += firstWord + " ";

    for (int i = 1; i < words; i++) {
      text += dummyTexts[rand.nextInt(size)] + (i == words - 1 ? "" : " ");
    }

    return text + (withStop ? "." : "");
  }

  Widget _singleReview(
      {required String image,
      required String name,
      required double rating,
      required String time,
      required String review}) {
    return Container(
      margin: Spacing.bottom(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Container(
                  margin: Spacing.left(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FxText.b2(name, fontWeight: 600),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FxStarRating(
                              rating: rating,
                              activeColor: Style.getTheme().primaryColor,
                              showInactive: false,
                              spacing: 0),
                          Spacing.width(4),
                          FxText.b2(rating.toString(), fontWeight: 600)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              FxText.caption(
                time,
                muted: true,
                fontWeight: 600,
              )
            ],
          ),
          Spacing.height(8),
          FxText.caption(
            "- " + review,
          )
        ],
      ),
    );
  }

  Widget _buildRatingWidget() {
    List<int> ratingList = [0, 1, 2, 3, 4, 5];
    List<Widget> list = [];
    int maxRating = 5;
    for (int i = 5; i > 0; i--) {
      int progress = ((ratingList[i] / maxRating) * 100).ceil();
      list.add(Row(
        children: [
          Container(
            child: FxText.caption(i.toString(),
                color: Style.getTheme().colorScheme.onBackground,
                fontWeight: 600),
          ),
          Spacing.width(4),
          Icon(
            MdiIcons.starOutline,
            color: Style.getTheme().colorScheme.onBackground,
            size: 10,
          ),
          Expanded(
            child: Container(
              margin: Spacing.left(8),
              height: 4,
              decoration: BoxDecoration(
                  color:
                      Style.getTheme().colorScheme.onBackground.withAlpha(60),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: progress,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                          color: getColorByRating()[i],
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                  ),
                  Expanded(
                    flex: 100 - progress,
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: Spacing.left(8),
            child: FxText.caption(ratingList[i].toString(),
                color: Style.getTheme().colorScheme.onBackground, muted: true),
          )
        ],
      ));
    }

    return FxContainer(
      padding: Spacing.all(16),
      bordered: true,
      border: Border.all(color: CustomStyle.getTheme().border),
      background: CustomStyle.getTheme().card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  margin: Spacing.fromLTRB(8, 0, 16, 0),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: Spacing.fromLTRB(0, 4, 2, 0),
                              child: FxText.sh2("4.6",
                                  fontWeight: 600, letterSpacing: 0.25),
                            ),
                            Icon(
                              MdiIcons.starOutline,
                              color: Style.getTheme().colorScheme.onBackground,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: Spacing.top(4),
                        child: FxText.caption("15 Ratings", muted: true),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: list,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
