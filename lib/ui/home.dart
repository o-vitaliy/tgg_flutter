import 'package:flutter/material.dart';
import 'package:tgg/models/blueprint_model.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/tabs/home_tab.dart';
import 'package:tgg/ui/toolbar/HomeToolbar.dart';
import 'package:tgg/ui/widgets/stream_loading_page.dart';

import '../blocs/blueprint_bloc.dart';
import 'helpers/route_tab_mapper.dart';

typedef void TabItemClickCallback(RouteMode data);

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  RouteMode selectedMode;

  @override
  void initState() {
    super.initState();
    bloc.fetchBlueprint();
  }

  @override
  void dispose() {
    bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                StreamLoadingPage(bloc.blueprint, (data) => buildPage(data))));
  }

  Widget buildPage(BlueprintModel blueprint) {
    if (selectedMode == null) selectedMode = blueprint.routing.modes.first;
    RouteTabMapper mapper =
        RouteTabMapper(() => HomeTab(blueprint.routing, pageSelected));

    return Column(children: <Widget>[
      HomeToolbar(pageSelected, blueprint.routing, selectedMode),
      mapper.map(selectedMode.name)
    ]);
  }

  void pageSelected(RouteMode mode) {
    setState(() {
      selectedMode = mode;
    });
  }
}
