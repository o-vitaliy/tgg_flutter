import 'package:flutter/material.dart';
import 'package:tgg/common/theme/theme_config.dart';

class MainButton extends RaisedButton {
  MainButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color disabledTextColor,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    VisualDensity visualDensity,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: themeConfig.foregroundInverse,
          disabledTextColor: disabledTextColor,
          color: themeConfig.primary,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          visualDensity: visualDensity,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );
}

class SecondaryButton extends RaisedButton {
  SecondaryButton({
    Key key,
    @required VoidCallback onPressed,
    VoidCallback onLongPress,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color disabledTextColor,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    VisualDensity visualDensity,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: themeConfig.foreground,
          disabledTextColor: disabledTextColor,
          color: themeConfig.secondaryButtonColor,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          visualDensity: visualDensity,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );
}

RaisedButton getButton(
  bool isMain, {
  Key key,
  @required VoidCallback onPressed,
  VoidCallback onLongPress,
  ValueChanged<bool> onHighlightChanged,
  ButtonTextTheme textTheme,
  Color disabledTextColor,
  Color disabledColor,
  Color focusColor,
  Color hoverColor,
  Color highlightColor,
  Color splashColor,
  Brightness colorBrightness,
  double elevation,
  double focusElevation,
  double hoverElevation,
  double highlightElevation,
  double disabledElevation,
  EdgeInsetsGeometry padding,
  VisualDensity visualDensity,
  ShapeBorder shape,
  Clip clipBehavior = Clip.none,
  FocusNode focusNode,
  bool autofocus = false,
  MaterialTapTargetSize materialTapTargetSize,
  Duration animationDuration,
  Widget child,
}) {
  if (isMain) {
    return MainButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      disabledTextColor: disabledTextColor,
      disabledColor: disabledColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      focusElevation: focusElevation,
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      child: child,
    );
  } else {
    return SecondaryButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      disabledTextColor: disabledTextColor,
      disabledColor: disabledColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      focusElevation: focusElevation,
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      child: child,
    );
  }
}

RaisedButton getMainTextButton(
    {@required String label, @required VoidCallback onPressed}) {
  return getMainContentButton(
      content: Text(label, style: themeConfigButtonTextStyle),
      onPressed: onPressed);
}

RaisedButton getMainContentButton(
    {@required Widget content, @required VoidCallback onPressed}) {
  return MainButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content,
      ),
      onPressed: onPressed);
}
