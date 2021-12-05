import 'package:flutter/material.dart';
import 'package:zerodezenove/configurations/style.dart';

class Category {
  final String image, title;
  final Color color;

  Category(this.image, this.title, this.color);

  static List<Category> getList() {
    return [
      Category("./assets/images/apps/grocery/strawberry.png", "Fruit",
          CustomStyle.red.withAlpha(50)),
      Category("./assets/images/apps/grocery/bread.png", "Bread",
          CustomStyle.orange.withAlpha(60)),
      Category("./assets/images/apps/grocery/broccoli.png", "Veggie",
          CustomStyle.green.withAlpha(50)),
      Category("./assets/images/apps/grocery/cheese.png", "Dairy",
          CustomStyle.yellow.withAlpha(70)),
    ];
  }
}
