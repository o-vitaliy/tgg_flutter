import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/routing/routing_middleware.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/common/theme/theme_config.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';
import 'package:tgg/common/theme/themed_buttons.dart';

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

  bool get isMain => mode.name == ModeHelper.to(Mode.main);

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
    return getButton(
      isMain,
      onPressed: !delayed ? () => widget.onPressed(mode) : null,
      child: Padding(
        padding: const EdgeInsets.all(themeConfigButtonPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(IconMapper.map(mode.icon)),
            ),
            Text(
              widget.flavor.get("modes:${mode.name}:title"),
              style: themeConfigButtonTextStyle,
            ),
            buildTimer(delayed),
          ],
        ),
      ),
    );
  }

  Widget buildTimer(bool delayed) {
    if (!delayed) return SizedBox.shrink();

    final milliseconds = computeDelay(widget.startTime, mode.delay);
    final time = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final timeText = DateFormat("mm:ss").format(time);
    return Text("(" + timeText + ")");
  }
}
