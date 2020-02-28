import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tinycolor/tinycolor.dart';

final themeConfig = ThemeConfig();

const double themeConfigButtonPadding = 8;
const TextStyle themeConfigButtonTextStyle = TextStyle(fontSize: 16);

const TextStyle headerTextStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

class ThemeConfig {
  Flavor flavor;

  Color get primary =>
      flavor?.color("primary:color")?.color ?? const Color(0xfff47421);

  Color get background =>
      flavor?.color("background:color")?.color ?? foregroundInverse;

  Color get navBarBackground =>
      flavor?.color("navBarBackground:color")?.color ?? background;

  Color get foregroundAlt =>
      flavor?.color("foregroundAlt:color")?.color ?? const Color(0xff333333);

  Color get foreground =>
      flavor?.color("foreground:color")?.color ?? const Color(0xff333333);

  Color get foregroundInverse =>
      flavor?.color("foregroundInverse:color")?.color ?? foreground;

  Color get secondaryButtonColor => TinyColor(background).darken(5).color;

  Color get fontColor => flavor?.color("font:color")?.color ?? Colors.black;

  Image get navHeaderImage => _getImage("nav:header:image");

  Image get navFooterImage => _getImage("nav:footer:image");

  Image _getImage(String key) {
    final path = flavor?.get(key);
    if (path == null || path == "") return null;
    return Image.network(path);
  }
}
