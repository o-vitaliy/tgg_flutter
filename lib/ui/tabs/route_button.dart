import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/routing/routing_middleware.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';

class RouteButton extends StatefulWidget {
  final Flavor flavor;
  final RouteMode mode;
  final Function(RouteMode) onPressed;
  final DateTime startTime;

  const RouteButton({
    Key key,
    this.flavor,
    this.mode,
    this.startTime,
    this.onPressed,
  }) : super(key: key);

  @override
  State createState() => _RouteButtonState();
}

class _RouteButtonState extends State<RouteButton> {
  RouteMode get mode => widget.mode;

  Timer timer;

  bool get isTimerActive => isTimerRunning(widget.startTime, mode.delay);

  @override
  void initState() {
    super.initState();
    if (isTimerActive) {
      timer = Timer.periodic(Duration(seconds: 1), (_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delayed = isTimerActive;

    if (!delayed) {
      timer?.cancel();
      timer = null;
    }
    return RaisedButton(
        onPressed: !delayed ? () => widget.onPressed(mode) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(IconMapper.map(mode.icon), color: Colors.white),
            ),
            Text(
              widget.flavor.get("modes:${mode.name}:title"),
            ),
            buildTimer(delayed),
          ],
        ),
        textColor: Colors.white);
  }

  Widget buildTimer(bool delayed) {
    if (!delayed) return SizedBox.shrink();

    final milliseconds = computeDelay(widget.startTime, mode.delay);
    final time = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final timeText = DateFormat("mm:ss").format(time);
    return Text("(" + timeText + ")");
  }
}
