import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/configurations/style.dart';
import 'package:flutter/material.dart';

enum FxShadowPosition {
  topLeft,
  top,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottom,
  bottomRight
}

class FxShadow {
  late int alpha;
  late double elevation, spreadRadius, blurRadius;
  Offset? offset;
  FxShadowPosition? position;
  Color? color;
  bool? darkShadow;

  FxShadow(
      {double elevation = 8,
      double? spreadRadius,
      double? blurRadius,
      Offset? offset,
      FxShadowPosition position = FxShadowPosition.bottom,
      int? alpha,
      Color? color,
      bool darkShadow = false}) {
    this.spreadRadius = spreadRadius ?? elevation * 0.125;
    this.blurRadius = blurRadius ?? elevation * 2;
    this.alpha = alpha != null ? alpha : (darkShadow ? 100 : 36);
    this.elevation = elevation;
    this.offset = offset;
    this.position = position;
    this.color = color;
    this.darkShadow = darkShadow;

    if (offset == null) {
      switch (position) {
        case FxShadowPosition.topLeft:
          this.offset = Offset(-elevation, -elevation);
          break;
        case FxShadowPosition.top:
          this.offset = Offset(0, -elevation);
          break;
        case FxShadowPosition.topRight:
          this.offset = Offset(elevation, -elevation);
          break;
        //TODO: Shadow problem
        case FxShadowPosition.centerLeft:
          this.offset = Offset(-elevation, elevation * 0.25);
          break;
        case FxShadowPosition.center:
          this.offset = Offset(0, 0);
          break;
        //TODO: Shadow problem
        case FxShadowPosition.centerRight:
          this.offset = Offset(elevation, elevation * 0.25);
          break;
        case FxShadowPosition.bottomLeft:
          this.offset = Offset(-elevation, elevation);
          break;
        case FxShadowPosition.bottom:
          this.offset = Offset(0, elevation);
          break;
        case FxShadowPosition.bottomRight:
          this.offset = Offset(elevation, elevation);
          break;
      }
    }
  }

  @override
  String toString() {
    return 'FxShadow{alpha: $alpha, elevation: $elevation, spreadRadius: $spreadRadius, blurRadius: $blurRadius, offset: $offset, position: $position, color: $color, darkShadow: $darkShadow}';
  }
}

class FxCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double? borderRadiusAll, paddingAll, marginAll;
  final EdgeInsetsGeometry? padding, margin;
  final Color? color;
  final GestureTapCallback? onTap;
  final bool bordered;
  final Border? border;
  final Clip? clipBehavior;
  final BoxShape? boxShape;
  final FxShadow? shadow;
  final double? width, height;
  final Color? splashColor;
  const FxCard(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.color,
      this.paddingAll,
      this.onTap,
      this.border,
      this.bordered = false,
      this.clipBehavior,
      this.boxShape,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height})
      : super(key: key);
  const FxCard.bordered(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.color,
      this.paddingAll,
      this.onTap,
      this.border,
      this.bordered = true,
      this.clipBehavior,
      this.boxShape,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height})
      : super(key: key);
  const FxCard.rounded(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll,
      this.color,
      this.paddingAll,
      this.onTap,
      this.border,
      this.bordered = false,
      this.clipBehavior = Clip.antiAliasWithSaveLayer,
      this.boxShape = BoxShape.circle,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height})
      : super(key: key);

  const FxCard.none(
      {Key? key,
      required this.child,
      this.borderRadius,
      this.padding,
      this.borderRadiusAll = 0,
      this.color,
      this.paddingAll = 0,
      this.onTap,
      this.border,
      this.bordered = false,
      this.clipBehavior = Clip.antiAliasWithSaveLayer,
      this.boxShape = BoxShape.rectangle,
      this.shadow,
      this.marginAll,
      this.margin,
      this.splashColor,
      this.width,
      this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    FxShadow myShadow = shadow ?? FxShadow();
    return InkWell(
      borderRadius: boxShape != BoxShape.circle
          ? borderRadius ??
              BorderRadius.all(Radius.circular(borderRadiusAll ?? 8))
          : null,
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: splashColor ?? Colors.transparent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? Spacing.all(marginAll ?? 0),
        decoration: BoxDecoration(
            color: color ?? Style.getThemeData().cardTheme.color,
            borderRadius: boxShape != BoxShape.circle
                ? borderRadius ??
                    BorderRadius.all(Radius.circular(borderRadiusAll ?? 8))
                : null,
            border: bordered
                ? border ??
                    Border.all(
                        color: Style.getThemeData().dividerColor, width: 1)
                : null,
            shape: boxShape ?? BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                  color: myShadow.color ??
                      Style.getThemeData()
                          .shadowColor
                          .withAlpha(myShadow.alpha),
                  spreadRadius: myShadow.spreadRadius,
                  blurRadius: myShadow.blurRadius,
                  offset: myShadow.offset!)
            ]),
        padding: padding ?? Spacing.all(paddingAll ?? 16),
        clipBehavior: clipBehavior ?? Clip.none,
        child: child,
      ),
    );
  }
}
