import 'package:flutter/material.dart';
import 'package:tgg/models/blueprint_model.dart';
import 'package:tgg/ui/toolbar/HomeToolbar.dart';

import '../blocs/blueprint_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
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
            child: StreamBuilder(
      stream: bloc.blueprint,
      builder: (context, AsyncSnapshot<BlueprintModel> snapshot) {
        if (snapshot.hasData) {
          return buildPage(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return Center(child: CircularProgressIndicator());
      },
    )));
  }

  Widget buildPage(AsyncSnapshot<BlueprintModel> snapshot) {
    return Column(children: <Widget>[
      HomeToolbar(),
      Text(snapshot.data.toJson().toString())
    ]);
  }
}
