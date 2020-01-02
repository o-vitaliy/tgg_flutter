import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/auth/login.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/helpers/icon_mapper.dart';
import 'package:tgg/ui/routes.dart';

class HomeTab extends StatelessWidget {
  final List<RouteMode> modes;
  final Function(RouteMode) pageSelected;

  const HomeTab(this.modes, this.pageSelected, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = modes.map(buildButton).toList();
    buttons.add(buildBonus());
    buttons.add(logoutButton(context));
    return Align(
        widthFactor: 0.8,
        child: Column(
          children: buttons,
        ));
  }

  Widget buildBonus() {
    RouteMode mode = RouteMode();
    mode.icon = "icon-camera";
    mode.title = "Bonus camera";
    mode.name = TAB_ROUTE_BONUS_CAMERA;
    return buildButton(mode);
  }

  Widget logoutButton(BuildContext context) {
    //final LoginBloc authenticationBloc = BlocProvider.of<LoginBloc>(context);
    return RaisedButton(
        onPressed: () => null,//authenticationBloc.dispatch(Logout()),
        child:
            Padding(padding: EdgeInsets.only(left: 8), child: Text("Logout")),
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
                mode.title,
              ))
        ],
      ),
      textColor: Colors.white);
}
