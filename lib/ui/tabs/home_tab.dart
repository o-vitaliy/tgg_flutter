import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/routing.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';
import 'package:tgg/ui/home.dart';

class HomeTab extends StatelessWidget {
  final Routing routing;
  final TabItemClickCallback pageSelected;

  const HomeTab(this.routing, this.pageSelected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.8,
      child: Column(
        children: routing.modes.map(buildButton).toList(),
      ),
    );
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
