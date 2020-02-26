import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';

class HomeTab extends StatelessWidget {
  final Flavor _flavor;
  final List<RouteMode> modes;
  final Function(RouteMode) pageSelected;
  final Function logout;

  const HomeTab(this._flavor, this.modes, this.pageSelected, this.logout,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = modes.map(buildButton).toList();
    buttons.add(logoutButton(context));
    return Column(
      children: buttons,
    );
  }

  Widget logoutButton(BuildContext context) {
    return RaisedButton(
        onPressed: logout,
        child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8), child: Text("Logout")),
        textColor: Colors.white);
  }

  Widget buildButton(RouteMode mode) => RaisedButton(
      onPressed: () => pageSelected(mode),
      child: Row(
        children: <Widget>[
          Icon(IconMapper.map(mode.icon), color: Colors.white),
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                _flavor.get("modes:${mode.name}:title"),
              ))
        ],
      ),
      textColor: Colors.white);
}
