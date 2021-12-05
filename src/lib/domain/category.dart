import 'package:flutter/material.dart';
import 'package:zerodezenove/configurations/skin.dart';

class Category {
  final String image, title;
  final Color color;

  Category(this.image, this.title, this.color);

  static List<Category> getList() {
    return [
      Category("./assets/images/apps/grocery/strawberry.png", "Fruit",
          CustomSkin.red.withAlpha(50)),
      Category("./assets/images/apps/grocery/bread.png", "Bread",
          CustomSkin.orange.withAlpha(60)),
      Category("./assets/images/apps/grocery/broccoli.png", "Veggie",
          CustomSkin.green.withAlpha(50)),
      Category("./assets/images/apps/grocery/cheese.png", "Dairy",
          CustomSkin.yellow.withAlpha(70)),
    ];
  }
}
