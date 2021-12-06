import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zerodezenove/src/configurations/style.dart';

enum Elements {
  h4,
  h5,
  h6,
  sh1,
  sh2,
  button,
  caption,
  overline,
  d1,
  d2,
  d3,
  h1,
  h2,
  h3,
  t1,
  t2,
  t3,
  l1,
  l2,
  l3,
  b1,
  b2,
  b3
}

class Typography {
  static Map<int, FontWeight> _fontWeight = {
    100: FontWeight.w100,
    200: FontWeight.w200,
    300: FontWeight.w300,
    400: FontWeight.w300,
    500: FontWeight.w400,
    600: FontWeight.w500,
    700: FontWeight.w600,
    800: FontWeight.w700,
    900: FontWeight.w800,
  };

  static Map<Elements, int> _textFontWeight = {
    Elements.h4: 500,
    Elements.h5: 500,
    Elements.h6: 500,
    Elements.sh1: 500,
    Elements.sh2: 500,
    Elements.button: 500,
    Elements.caption: 500,
    Elements.overline: 500,
    Elements.d1: 500,
    Elements.d2: 500,
    Elements.d3: 500,
    Elements.h1: 500,
    Elements.h2: 500,
    Elements.h3: 500,
    Elements.t1: 500,
    Elements.t2: 500,
    Elements.t3: 500,
    Elements.l1: 600,
    Elements.l2: 600,
    Elements.l3: 600,
    Elements.b1: 500,
    Elements.b2: 500,
    Elements.b3: 500,
  };

  static Map<Elements, double> _letteringSpacing = {
    Elements.h4: 0,
    Elements.h5: 0,
    Elements.h6: 0,
    Elements.sh1: 0.15,
    Elements.sh2: 0.15,
    Elements.button: 0.15,
    Elements.caption: 0.15,
    Elements.overline: 0.15,
    Elements.d1: -0.25,
    Elements.d2: 0,
    Elements.d3: 0,
    Elements.h1: -0.2,
    Elements.h2: -0.15,
    Elements.h3: 0,
    Elements.t1: 0,
    Elements.t2: 0.1,
    Elements.t3: 0.1,
    Elements.l1: 0.1,
    Elements.l2: 0.5,
    Elements.l3: 0.5,
    Elements.b1: 0.5,
    Elements.b2: 0.25,
    Elements.b3: 0.4,
  };

  static Map<Elements, double> _textSize = {
    Elements.h4: 36,
    Elements.h5: 25,
    Elements.h6: 21,
    Elements.sh1: 17,
    Elements.sh2: 15,
    Elements.button: 13,
    Elements.caption: 12,
    Elements.overline: 10,
    Elements.d1: 57,
    Elements.d2: 45,
    Elements.d3: 36,
    Elements.h1: 32,
    Elements.h2: 28,
    Elements.h3: 26,
    Elements.t1: 22,
    Elements.t2: 16,
    Elements.t3: 14,
    Elements.l1: 14,
    Elements.l2: 12,
    Elements.l3: 11,
    Elements.b1: 16,
    Elements.b2: 14,
    Elements.b3: 12,
  };

  static TextDirection _textDirection = TextDirection.ltr;

  static Function _fontFamily = GoogleFonts.signika;

  static void setFontFamily(Function fontFamily) {
    _fontFamily = fontFamily;
  }

  static void setFontWeight(Map<int, FontWeight> fontWeight) {
    _fontWeight = fontWeight;
  }

  static void setTextSize(Map<Elements, double> textSize) {
    _textSize = textSize;
  }

  static void setTextDirection(TextDirection textDirection) {
    _textDirection = textDirection;
  }

  static TextDirection getTextDirection() {
    return _textDirection;
  }

  static Map<Elements, int> getTextFontWeight() {
    return _textFontWeight;
  }

  static Map<Elements, double> getLetteringSpacing() {
    return _letteringSpacing;
  }

  static Map<Elements, double> getTextSize() {
    return _textSize;
  }

  static TextStyle getText(
      {TextStyle? TextStyle,
      int? fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double letterSpacing = 0.15,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    double? finalFontSize = fontSize != null ? fontSize : TextStyle!.fontSize;

    Color? finalColor;

    if (color == null) {
      var themeColor = Style.getThemeData().colorScheme.onBackground;

      finalColor = xMuted
          ? themeColor.withAlpha(160)
          : (muted ? themeColor.withAlpha(200) : themeColor);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return _fontFamily(
        fontSize: finalFontSize,
        fontWeight: _letteringSpacing[_fontWeight] ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  static TextStyle h4(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.h4],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.h4] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h5(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.h5],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.h5] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h6(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.h6],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.h6] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle sh1(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.sh1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.sh1] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle sh2(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.sh2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.sh2] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle button(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.button],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _letteringSpacing[Elements.button] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle caption(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing = 0,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.caption],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _letteringSpacing[Elements.caption] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle overline(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.overline],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _letteringSpacing[Elements.overline] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle d1(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.d1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.d1] ?? -0.2,
        fontWeight: _textFontWeight[Elements.d1] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle d2(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.d2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.d2] ?? -0.2,
        fontWeight: _textFontWeight[Elements.d2] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle d3(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.d3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.d3] ?? -0.2,
        fontWeight: _textFontWeight[Elements.d3] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h1(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.h1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.h1] ?? -0.2,
        fontWeight: _textFontWeight[Elements.h1] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h2(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.h2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.h2] ?? -0.15,
        fontWeight: _textFontWeight[Elements.h2] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle h3(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.h3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.h3] ?? -0.15,
        fontWeight: _textFontWeight[Elements.h3] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle t1(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.t1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.t1] ?? -0.15,
        fontWeight: _textFontWeight[Elements.t1] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle t2(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.t2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.t2] ?? -0.15,
        fontWeight: _textFontWeight[Elements.t2] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle t3(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.t3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.t3] ?? -0.15,
        fontWeight: _textFontWeight[Elements.t3] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle l1(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.l1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.l1] ?? -0.15,
        fontWeight: _textFontWeight[Elements.l1] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle l2(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.l2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.l2] ?? -0.15,
        fontWeight: _textFontWeight[Elements.l2] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle l3(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.l3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.l3] ?? -0.15,
        fontWeight: _textFontWeight[Elements.l3] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle b1(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.b1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.b1] ?? 0.15,
        fontWeight: _textFontWeight[Elements.b1] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle b2(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.b2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.b2] ?? 0.15,
        fontWeight: _textFontWeight[Elements.b2] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle b3(
      {TextStyle? TextStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getText(
        fontSize: fontSize ?? _textSize[Elements.b3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _letteringSpacing[Elements.b3] ?? 0.15,
        fontWeight: _textFontWeight[Elements.b3] ?? 500,
        decoration: decoration,
        TextStyle: TextStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }
}
