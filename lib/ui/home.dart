import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/routing/route_actions.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_container.dart';
import 'package:tgg/containers/home/post_location_container.dart';
import 'package:tgg/models/modes.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          converter: _ViewModel.fromStore,
          builder: (BuildContext context, _ViewModel vm) {
            return buildPage(vm);
          },
        ),
      ),
    );
  }

  Widget buildPage(_ViewModel vm) {
    final homeTabBuilder = (key) => HomeTab(
        vm.flavor, vm.startTime, vm.modes, vm.changeMode, vm.logout,
        key: key);
    RouteTabMapper mapper = RouteTabMapper(homeTabBuilder: homeTabBuilder);

    return Column(children: <Widget>[
      HomeToolbar(vm.flavor, vm.changeMode, vm.modes, vm.selectedMode),
      UploadContainer(),
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: mapper.map(vm.selectedMode?.name ?? "home"),
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
  final DateTime startTime;

  final Function(RouteMode) changeMode;
  final Function logout;

  _ViewModel({
    this.flavor,
    this.selectedMode,
    this.modes,
    this.startTime,
    this.changeMode,
    this.logout,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.homePageState;
    final startTime = store.state.playthrough.playthrough.startedAt;
    return _ViewModel(
        flavor: store.state.flavor,
        selectedMode: state.selectedMode,
        startTime: startTime,
        modes: state.activeModes,
        changeMode: (RouteMode mode) =>
            store.dispatch(RouteChangeCurrentModeAction(mode)),
        logout: () => store.dispatch(LogOut()));
  }
}
