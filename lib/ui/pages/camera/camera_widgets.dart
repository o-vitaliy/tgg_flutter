import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera.dart';

class CameraBlocWidget extends StatelessWidget {
  final BlocWidgetBuilder<CameraState> builder;
  final BlocBuilderCondition<CameraState> condition;

  const CameraBlocWidget({Key key, @required this.builder, this.condition})
      : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final cameraBloc = BlocProvider.of<CameraBloc>(context);
    return BlocBuilder<CameraBloc, CameraState>(
      bloc: cameraBloc,
      builder: builder,
      condition: condition,
    );
  }
}

class CameraControlsBlocWidget extends StatelessWidget {
  final WidgetBuilder builder;

  const CameraControlsBlocWidget({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CameraControlsBloc>(context);
    return BlocBuilder<CameraControlsBloc, CameraControlsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CameraControlsVisibleState)
          return builder(context);
        else
          return SizedBox.shrink();
      },
    );
  }
}
