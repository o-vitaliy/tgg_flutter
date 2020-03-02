import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

import 'camera_actions.dart';
import 'camera_middleware.dart';
import 'camera_reducer.dart';
import 'camera_state.dart';

class CameraPage extends StatelessWidget {
  static const routeName = '/camera';

  final store = new Store<CameraState>(cameraReducer,
      initialState: CameraState.initial(),
      middleware: []..addAll(createCameraMiddleware()));

  @override
  Widget build(BuildContext context) {
    final CaptureArguments args = ModalRoute.of(context).settings.arguments;
    store.dispatch(StartInitCameraAction(args, cameraKey));
    return Scaffold(
        backgroundColor: Colors.black,
        body: new StoreProvider(
          store: store,
          child: CameraContainer(),
        ));
  }
}
