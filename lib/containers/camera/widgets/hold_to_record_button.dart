import 'package:flutter/material.dart';

class HoldToRecordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(shape: _TapToRecordBorder()),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          "Hold to\nrecord",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }
}

class _TapToRecordBorder extends ShapeBorder {
  static const Color borderColor = Colors.white;
  static const Color bodyColor = Colors.red;

  @override
  void paint(Canvas canvas, Rect size, {TextDirection textDirection}) {
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint bodyPaint = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill;

    const padding = 4;

    canvas.drawRRect(
        RRect.fromLTRBR(size.left, size.top, size.left + size.width,
            size.top + size.height, Radius.circular(padding * 3.0)),
        borderPaint);

    canvas.drawRRect(
        RRect.fromLTRBR(
            size.left + padding,
            size.top + padding,
            size.left + size.width - padding,
            size.top + size.height - padding,
            Radius.circular(padding * 2.0)),
        bodyPaint);
  }

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}
