import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/preview/preview_actions.dart';
import 'package:tgg/containers/preview/video/video_preview_actions.dart';
import 'package:tgg/ui/colors.dart';
import 'package:tgg/ui/keys.dart';
import 'package:tgg/ui/pages/preview/preview.dart';
import 'package:tgg/ui/pages/preview/preview_controls/video_preview_widget.dart';
import 'package:tgg/ui/pages/preview/preview_controls/video_progress_widget.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';
import 'package:tgg/ui/widgets/text_button.dart';
import 'package:video_player/video_player.dart';

import '../preview_state.dart';

class VideoPreviewContainer extends StatelessWidget {
  VideoPreviewContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<PreviewState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                  child: vm.initialized
                      ? LoadingIndicator()
                      : Stack(
                          children: <Widget>[
                            buildPreview(vm),
                            buildControls(vm),
                          ],
                        )));
        });
    ;
  }

  Widget buildPreview(_ViewModel vm) =>
      VideoPreviewWidget(vm.controller, key: Keys.previewVideoWidget);

  Widget buildControls(_ViewModel vm) {
    if (vm.isPlaying) {
      return buildPlayingPreviewControls(vm);
    } else {
      if (vm.firstTime) {
        return buildFirstTimePreviewControls(vm);
      } else {
        return buildPreviewControls(vm);
      }
    }
  }

  Widget buildFirstTimePreviewControls(_ViewModel vm) {
    return Stack(
      children: <Widget>[
        SizedBox.fromSize(
            size: Size.fromHeight(rowHeight),
            child: Container(
                child: Center(
                    child: Text(
                  "Review video",
                  style: defaultTextStyle,
                )),
                color: defaultBackground)),
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox.fromSize(
                size: Size.fromHeight(rowHeight),
                child: Container(
                  color: defaultBackground,
                  child: CenteredTextButton(
                    text: "Review",
                    onTap: (_) => vm.play(),
                  ),
                ))),
      ],
    );
  }

  Widget buildPreviewControls(_ViewModel vm) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.fromSize(
          size: Size.fromHeight(rowHeight),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                height: 48,
                color: defaultBackground,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    text: "Back",
                    onTap: vm.retake,
                  )),
              Center(
                child: TextButton(
                  text: "Play",
                  onTap: (context) => vm.play(),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    text: "Submit",
                    onTap: vm.submit,
                  )),
            ],
          )),
    );
  }

  Widget buildPlayingPreviewControls(_ViewModel vm) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.fromSize(
        size: Size.fromHeight(rowHeight),
        child: Container(
          color: defaultBackground,
          child: Stack(
            children: <Widget>[
              VideoProgressWidget(
                vm.controller,
                onComplete: () => {},
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        text: "Skip",
                        onTap: (context) => vm.stop(),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class _ViewModel {
  final bool initialized;
  final bool isPlaying;
  final VideoPlayerController controller;
  final int rotation;
  final bool firstTime;

  final Function play;
  final Function stop;
  final Function(BuildContext context) retake;
  final Function(BuildContext context) submit;

  _ViewModel({
    this.initialized,
    this.isPlaying,
    this.controller,
    this.rotation,
    this.firstTime,
    this.play,
    this.stop,
    this.retake,
    this.submit,
  });

  static _ViewModel fromStore(Store<PreviewState> store) {
    final state = store.state;
    return _ViewModel(
      initialized: state.videoPreviewState.initialized,
      isPlaying: state.videoPreviewState.isPlaying,
      controller: state.videoPreviewState.controller,
      firstTime: state.videoPreviewState.firstTimePlayed,
      play: () => store.dispatch(PlayVideoAction()),
      stop: () => store.dispatch(StopVideoAction()),
      retake: (BuildContext context) =>
          store.dispatch(RetakePreviewAction(context)),
      submit: (BuildContext context) =>
          store.dispatch(SubmitPreviewAction(context)),
    );
  }
}
