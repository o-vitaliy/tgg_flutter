import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/home_actions.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_container.dart';
import 'package:tgg/containers/home/post_location_container.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/keys.dart';
import 'package:tgg/ui/tabs/home_tab.dart';
import 'package:tgg/ui/tabs/route_tab_mapper.dart';
import 'package:tgg/ui/toolbar/HomeToolbar.dart';

typedef TabItemClickCallback = void Function(RouteMode data);

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  HomePage() : super(key: Keys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return PostLocationContainer(
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
    return SafeArea(
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          converter: _ViewModel.fromStore,
          builder: (BuildContext context, _ViewModel vm) {
            return buildPage(
                vm.flavor, vm.selectedMode, vm.modes, vm.changeMode, vm.logout);
          },
        ),
      ),
    );
  }

  Widget buildPage(
    Flavor flavor,
    RouteMode selectedMode,
    List<RouteMode> modes,
    Function(RouteMode) changeMode,
    Function logout,
  ) {
    final homeTabBuilder =
        (key) => HomeTab(flavor, modes, changeMode, logout, key: key);
    RouteTabMapper mapper = RouteTabMapper(homeTabBuilder: homeTabBuilder);

    return Column(children: <Widget>[
      HomeToolbar(flavor, changeMode, modes, selectedMode),
      UploadContainer(),
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: mapper.map(selectedMode?.name ?? "home"),
          ),
        ),
      ),
    ]);
  }
}

class _ViewModel {
  final Flavor flavor;
  final RouteMode selectedMode;
  final List<RouteMode> modes;

  final Function(RouteMode) changeMode;
  final Function logout;

  _ViewModel({
    this.flavor,
    this.selectedMode,
    this.modes,
    this.changeMode,
    this.logout,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.homePageState;
    final hasAnyTime = store.state.anytime?.missions?.isNotEmpty ?? false;
    final hasBonus =
        store.state.waypointsPassingState?.getWaypointForType(Mode.camera) !=
            null;
    return _ViewModel(
        flavor: store.state.flavor,
        selectedMode: state.selectedMode,
        modes: state.getModesFiltered(hasAnyTime, hasBonus),
        changeMode: (RouteMode mode) =>
            store.dispatch(ChangeRouteModeAction(mode)),
        logout: () => store.dispatch(LogOut()));
  }
}
