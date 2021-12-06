import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';

class Card extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? background;
  final AlignmentGeometry? alignment;
  final BoxShape shape;
  final GestureTapCallback? onTap;

  const Card({
    Key? key,
    required this.child,
    this.background,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.alignment,
    this.shape = BoxShape.rectangle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _container = Container(
      width: width,
      height: height,
      alignment: alignment,
      margin: margin ?? Spacing.all(0),
      decoration: BoxDecoration(
        color: background ?? null,
        shape: shape,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: null,
      ),
      padding: padding ?? Spacing.all(0),
      clipBehavior: Clip.none,
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: _container,
      );
    } else {
      return _container;
    }
  }
}
