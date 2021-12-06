import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';

class Screen extends StatelessWidget {
  final List<Widget> children;

  const Screen({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: Spacing.fromLTRB(4, 80, 4, 70),
        children: children,
      ),
    );
  }
}
