import 'dart:async';
import 'dart:math' as math;

import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

typedef TimerFinishedCallback = void Function();

class CountDownTimer extends StatefulWidget {
  final Duration maxValue;
  final Duration initialValue;
  final bool clockwise;
  final double startAngle;
  final TimerFinishedCallback finishedCallback;
  final Color color;

  const CountDownTimer(
    this.initialValue,
    this.maxValue, {
    Key key,
    this.clockwise = true,
    this.startAngle = 0,
    this.color = Colors.white,
    this.finishedCallback,
  }) : super(key: key);

  @override
  State createState() => CountDownTimerState(
        maxValue,
        initialValue,
        clockwise,
        startAngle,
        color,
        finishedCallback,
      );
}

class CountDownTimerState extends State<CountDownTimer> {
  final Duration maxValue;
  final bool _clockwise;
  final double _startAngle;
  final TimerFinishedCallback _finishedCallback;
  final Color _color;
  final millisFormat = NumberFormat("000");

  Duration currentValue;

  StreamSubscription _subscription;

  CountDownTimerState(
    this.maxValue,
    Duration initialValue,
    this._clockwise,
    this._startAngle,
    this._color,
    this._finishedCallback,
  ) {
    currentValue = initialValue;
  }

  @override
  void deactivate() {
    super.deactivate();
    stopTimer();
  }

  void startTimer() {
    _subscription = CountDown(currentValue, refresh: Duration(milliseconds: 10))
        .stream
        .listen(
      (onData) {
        if (mounted)
          setState(() {
            currentValue = onData;
          });
      },
      onDone: () {
        if (_finishedCallback != null) _finishedCallback();
      },
    );
  }

  void stopTimer() {
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return buildTimerView(currentValue);
  }

  Widget buildTimerView(Duration duration) {
    final size = Size.square(50);
    return SizedBox.fromSize(
        size: size,
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: _TimerBorderPainter(
                  1.0 - duration.inMilliseconds / maxValue.inMilliseconds,
                  _clockwise,
                  _startAngle,
                  _color),
              size: size,
            ),
            Align(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(duration.inSeconds.toString() + ".",
                      style: TextStyle(
                          color: _color,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text(
                      millisFormat.format(duration.inMilliseconds %
                          Duration.millisecondsPerSecond),
                      style: TextStyle(
                          color: _color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ));
  }
}

class _TimerBorderPainter extends CustomPainter {
  final double _progress;
  final bool _clockwise;
  final double _startAngle;
  final Color _color;

  _TimerBorderPainter(
      this._progress, this._clockwise, this._startAngle, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, 50, 50);
    final startAngle = this._startAngle - math.pi / 2.0;
    final sweepAngle =
        math.pi * 2.0 - math.pi * 2.0 * _progress * (_clockwise ? 1.0 : -1.0);
    final useCenter = false;
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
