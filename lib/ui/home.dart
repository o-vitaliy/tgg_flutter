import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/aws_upload/aws_upload_widget.dart';
import 'package:tgg/bloc/game/game.dart';
import 'package:tgg/models/blueprint_model.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/ui/pages/post_location/post_location_widget.dart';
import 'package:tgg/ui/tabs/home_tab.dart';
import 'package:tgg/ui/tabs/route_tab_mapper.dart';
import 'package:tgg/ui/toolbar/HomeToolbar.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

typedef TabItemClickCallback = void Function(RouteMode data);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PostLocationWidget(
      widgetBuilder: (context) => _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeStateContent();
}

class _HomeStateContent extends State<_HomePageContent> {
  RouteMode selectedMode;

  @override
  Widget build(BuildContext context) {
    final gameBloc = BlocProvider.of<GameBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder(
          bloc: gameBloc,
          builder: (BuildContext context, GameState state) {
            if (state is GameLoadedState) {
              return buildPage(state.game.blueprint);
            } else {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildPage(BlueprintModel blueprint) {
    if (selectedMode == null) selectedMode = blueprint.routing.modes.first;
    RouteTabMapper mapper =
        RouteTabMapper(() => HomeTab(blueprint.routing, pageSelected));

    return Column(children: <Widget>[
      HomeToolbar(pageSelected, blueprint.routing, selectedMode),
      AwsUploadWidget(widgetBuilder: (context) => mapper.map(selectedMode.name))
    ]);
  }

  void pageSelected(RouteMode mode) {
    setState(() {
      selectedMode = mode;
    });
  }
}
