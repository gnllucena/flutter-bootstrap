import 'dart:ui';

import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/configurations/skin.dart';
import 'package:flutter/material.dart';

class FxContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double? borderRadiusAll, paddingAll, marginAll;
  final EdgeInsetsGeometry? padding, margin;
  final Color? background;
  final bool bordered;
  final Border? border;
  final Clip? clipBehavior;
  final BoxShape shape;
  final double? width, height;
  final AlignmentGeometry? alignment;
  final GestureTapCallback? onTap;
  final Color? splashColor;
  final bool enableBorderRadius;

  const FxContainer(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.paddingAll,
      this.border,
      this.bordered = false,
      this.clipBehavior,
      this.background,
      this.shape = BoxShape.rectangle,
      this.width,
      this.height,
      this.alignment,
      this.enableBorderRadius = true,
      this.onTap,
      this.marginAll,
      this.margin,
      this.splashColor})
      : super(key: key);

  const FxContainer.none(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll = 0,
      this.paddingAll = 0,
      this.border,
      this.bordered = false,
      this.clipBehavior,
      this.enableBorderRadius = true,
      this.background,
      this.shape = BoxShape.rectangle,
      this.width,
      this.height,
      this.alignment,
      this.onTap,
      this.marginAll,
      this.margin,
      this.splashColor})
      : super(key: key);

  const FxContainer.bordered(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.paddingAll,
      this.border,
      this.bordered = true,
      this.enableBorderRadius = true,
      this.clipBehavior,
      this.background,
      this.shape = BoxShape.rectangle,
      this.width,
      this.height,
      this.alignment,
      this.onTap,
      this.marginAll,
      this.margin,
      this.splashColor})
      : super(key: key);

  const FxContainer.roundBordered(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.enableBorderRadius = true,
      this.paddingAll,
      this.border,
      this.bordered = true,
      this.clipBehavior,
      this.background,
      this.shape = BoxShape.circle,
      this.width,
      this.height,
      this.alignment,
      this.onTap,
      this.marginAll,
      this.margin,
      this.splashColor})
      : super(key: key);

  const FxContainer.rounded(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.enableBorderRadius = true,
      this.paddingAll,
      this.border,
      this.bordered = false,
      this.clipBehavior = Clip.antiAliasWithSaveLayer,
      this.background,
      this.shape = BoxShape.circle,
      this.width,
      this.height,
      this.alignment,
      this.onTap,
      this.marginAll,
      this.margin,
      this.splashColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget base = Container(
      width: width,
      height: height,
      alignment: alignment,
      margin: margin ?? Spacing.all(marginAll ?? 0),
      decoration: BoxDecoration(
          color: background ?? Skin.getTheme().cardTheme.color,
          shape: shape,
          borderRadius: enableBorderRadius
              ? (shape == BoxShape.rectangle
                  ? borderRadius ??
                      BorderRadius.all(Radius.circular(borderRadiusAll ?? 8))
                  : null)
              : null,
          border: bordered
              ? border ??
                  Border.all(color: Skin.getTheme().dividerColor, width: 1)
              : null),
      padding: padding ?? Spacing.all(paddingAll ?? 16),
      clipBehavior: clipBehavior ?? Clip.none,
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        borderRadius: shape != BoxShape.circle
            ? borderRadius ??
                BorderRadius.all(Radius.circular(borderRadiusAll ?? 8))
            : null,
        onTap: onTap,
        splashColor: splashColor ?? Colors.transparent,
        highlightColor: splashColor ?? Colors.transparent,
        child: base,
      );
    } else {
      return base;
    }
  }
}
