import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/routing.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';
import 'package:tgg/ui/home.dart';
import 'package:tgg/ui/routes.dart';
import 'package:tgg/ui/widgets/count_down_timer.dart';

class HomeTab extends StatelessWidget {
  final Routing routing;
  final TabItemClickCallback pageSelected;

  const HomeTab(this.routing, this.pageSelected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = routing.modes.map(buildButton).toList();
    buttons.add(buildBonus());
    return Align(
      widthFactor: 0.8,
      child: Stack(children: [
        Column(
          children: buttons,
        ),
        Column(
          children: <Widget>[CountDownTimer(Duration(seconds: 3), clockwise: true), CountDownTimer(Duration(seconds: 3), clockwise:false)],
        )
      ]),
    );
  }

  Widget buildBonus() {
    RouteMode mode = RouteMode();
    mode.icon = "icon-camera";
    mode.title = "Bonus camera";
    mode.name = TAB_ROUTE_BONUS_CAMERA;
    return buildButton(mode);
  }

  Widget buildButton(RouteMode mode) => RaisedButton(
      onPressed: () => pageSelected(mode),
      child: Row(
        children: <Widget>[
          Icon(IconMapper.map(mode.icon), color: Colors.white),
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                mode.title,
              ))
        ],
      ),
      textColor: Colors.white);
}
