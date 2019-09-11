import 'package:flutter/material.dart';

typedef TapCallback = void Function(BuildContext);

class BaseSquareIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double dimension;
  final TapCallback onTap;

  const BaseSquareIconButton(
      {Key key,
      this.icon,
      this.onTap,
      this.color = Colors.white,
      this.dimension = 58})
      : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0, 0, 0, 0),
      child: InkWell(
        onTap: () => onTap(context),
        child: SizedBox.fromSize(
          size: Size.square(dimension),
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
