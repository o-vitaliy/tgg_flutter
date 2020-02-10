import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/home_actions.dart';
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
  RouteMode selectedMode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          converter: _ViewModel.fromStore,
          builder: (BuildContext context, _ViewModel vm) {
            return buildPage(
                vm.selectedMode, vm.modes, vm.changeMode, vm.logout);
          },
        ),
      ),
    );
  }

  Widget buildPage(
    RouteMode selectedMode,
    List<RouteMode> modes,
    Function(RouteMode) changeMode,
    Function logout,
  ) {
    final homeTabBuilder =
        (key) => HomeTab(modes, changeMode, logout, key: key);
    RouteTabMapper mapper = RouteTabMapper(homeTabBuilder: homeTabBuilder);

    return Column(children: <Widget>[
      HomeToolbar(changeMode, modes, selectedMode),
      UploadContainer(
          widgetBuilder: (context) => mapper.map(selectedMode?.name ?? "home"))
    ]);
  }
}

class _ViewModel {
  final RouteMode selectedMode;
  final List<RouteMode> modes;

  final Function(RouteMode) changeMode;
  final Function logout;

  _ViewModel({this.selectedMode, this.modes, this.changeMode, this.logout});

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.homePageState;
    return _ViewModel(
        selectedMode: state.selectedMode,
        modes: state.modes,
        changeMode: (RouteMode mode) =>
            store.dispatch(ChangeRouteModeAction(mode)),
        logout: () => store.dispatch(LogOut()));
  }
}
