import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';

class Screen extends StatelessWidget {
  final List<Widget> children;
  final AppBar? appBar;
  final EdgeInsets? padding;

  const Screen({
    Key? key,
    required this.children,
    this.padding,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? null,
      body: ListView(
        padding: padding ?? Spacing.fromLTRB(4, 80, 4, 70),
        children: children,
      ),
    );
  }
}
