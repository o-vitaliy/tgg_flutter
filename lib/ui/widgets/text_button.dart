import 'package:flutter/material.dart';

typedef TapCallback = void Function(BuildContext);

class TextButton extends StatelessWidget {
  final String text;
  final Color color;
  final TapCallback onTap;

  const TextButton({Key key, this.text, this.onTap, this.color = Colors.white})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0, 0, 0, 0),
      child: InkWell(
        onTap: () => onTap(context),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

class CenteredTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final TapCallback onTap;
  final double height;

  const CenteredTextButton(
      {Key key,
      this.text,
      this.onTap,
      this.color = Colors.white,
      this.height = 48})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        size: Size.fromHeight(48),
        child: Container(
          alignment: Alignment.center,
          height: 48,
          child: TextButton(
            color: color,
            text: text,
            onTap: onTap,
          ),
        ));
  }
}
