import 'dart:math';

class Product {
  final String name, description, image;
  final double price, discountedPrice;

  Product(this.name, this.description, this.image, this.price,
      this.discountedPrice);

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

  static List<Product> getList() {
    return [
      Product("Orange Fresh Juice", "Generator.getDummyText(8)",
          "./assets/images/apps/grocery/product-2.png", 59.99, 49.99),
      Product("Fresh Carrot", getDummyText(8),
          "./assets/images/apps/grocery/product-5.png", 19.99, 19.99),
      Product("Juicy Grapes", getDummyText(8),
          "./assets/images/apps/grocery/product-3.png", 35, 35),
      Product("Green Broccoli", getDummyText(8),
          "./assets/images/apps/grocery/product-1.png", 39.99, 29.99),
      Product("Cauliflower", getDummyText(8),
          "./assets/images/apps/grocery/product-4.png", 25, 25),
    ];
  }
}
