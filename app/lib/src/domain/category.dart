import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/style.dart';

class Category {
  final int id;
  final String image, title;
  final Color color;

  Category(this.id, this.image, this.title, this.color);

  static List<Category> getList() {
    return [
      Category(1, "./assets/images/apps/grocery/strawberry.png", "Fruit",
          CustomStyle.getThemeData().red.withAlpha(50)),
      Category(2, "./assets/images/apps/grocery/bread.png", "Bread",
          CustomStyle.getThemeData().orange.withAlpha(60)),
      Category(3, "./assets/images/apps/grocery/broccoli.png", "Veggie",
          CustomStyle.getThemeData().green.withAlpha(50)),
      Category(4, "./assets/images/apps/grocery/cheese.png", "Dairy",
          CustomStyle.getThemeData().yellow.withAlpha(70)),
    ];
  }
}
