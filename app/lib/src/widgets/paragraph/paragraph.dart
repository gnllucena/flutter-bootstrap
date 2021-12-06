import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';

class Paragraph extends StatelessWidget {
  final List<Widget> children;

  const Paragraph({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
