import 'package:flutter/material.dart';
import 'package:zerodezenove/configurations/style.dart';

class Category {
  final String image, title;
  final Color color;

  Category(this.image, this.title, this.color);

  static List<Category> getList() {
    return [
      Category("./assets/images/apps/grocery/strawberry.png", "Fruit",
          CustomStyle.getThemeData().red.withAlpha(50)),
      Category("./assets/images/apps/grocery/bread.png", "Bread",
          CustomStyle.getThemeData().orange.withAlpha(60)),
      Category("./assets/images/apps/grocery/broccoli.png", "Veggie",
          CustomStyle.getThemeData().green.withAlpha(50)),
      Category("./assets/images/apps/grocery/cheese.png", "Dairy",
          CustomStyle.getThemeData().yellow.withAlpha(70)),
    ];
  }
}
