import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';

class FxButton extends StatelessWidget {
  // final ButtonStyle? style;

  // final VoidCallback? onPressed;

  // final
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            padding: Spacing.fromLTRB(12, 72, 12, 70),
            children: <Widget>[
          Padding(
              padding: Spacing.horizontal(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ))
        ]));
  }
}
