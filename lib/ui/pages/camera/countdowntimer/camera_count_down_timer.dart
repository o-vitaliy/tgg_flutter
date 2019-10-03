import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/ui/widgets/count_down_timer.dart';

import 'bloc.dart';

class CameraTimerWidget extends StatelessWidget {
  final Duration duration;

  final countDownTimerKey = GlobalKey<CountDownTimerState>();

  CameraTimerWidget({Key key, this.duration})
      : assert(duration != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CameraCountDownTimerBloc>(context);
    return BlocListener<CameraCountDownTimerBloc, CameraCountDownTimerState>(
      bloc: bloc,
      child: BlocBuilder<CameraCountDownTimerBloc, CameraCountDownTimerState>(
        condition: (prev, current) => prev != current,
        builder: (context, state) {
          if (state is CameraCountDownTimerHiddenState) {
            return SizedBox.shrink();
          }
          return CountDownTimer(
            duration,
            key: countDownTimerKey,
          );
        },
      ),
      listener: (context, state) {
        if (state is CameraCountDownTimerRunningState)
          countDownTimerKey.currentState.startTimer();

        if (state is CameraCountDownTimerPausedState)
          countDownTimerKey.currentState.stopTimer();
      },
    );
  }
}
