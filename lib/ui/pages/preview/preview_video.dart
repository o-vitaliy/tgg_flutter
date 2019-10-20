import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/aws_upload/bloc.dart';
import 'package:tgg/ui/colors.dart';
import 'package:tgg/ui/pages/preview/preview.dart';
import 'package:tgg/ui/pages/preview/preview_controls/video_preview_widget.dart';
import 'package:tgg/ui/pages/preview/preview_controls/video_progress_widget.dart';
import 'package:tgg/ui/widgets/text_button.dart';
import 'package:video_player/video_player.dart';

import 'preview_controls/bloc.dart';

class VideoPreview extends StatelessWidget {
  final String videoLink;
  final PreviewControlsBloc bloc = PreviewControlsBloc();

  VideoPreview({Key key, this.videoLink}) : super(key: key) {
    bloc.dispatch(InitControlsEvent(videoLink));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => bloc,
      child: VideoPreviewContent(videoLink: videoLink),
    );
  }
}

class VideoPreviewContent extends StatefulWidget {
  final String videoLink;

  const VideoPreviewContent({Key key, @required this.videoLink})
      : assert(videoLink != null),
        super(key: key);

  @override
  State createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreviewContent> {
  String get videoLink => this.widget.videoLink;

  PreviewControlsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PreviewControlsBloc>(context);
  }

  @override
  void deactivate() {
    _bloc?.dispatch(DisposePreviewEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildPreview(),
        buildControls(),
      ],
    );
  }

  Widget buildPreview() {
    return BlocBuilder(
      bloc: _bloc,
      condition: (oldState, newState) =>
          (oldState is InitialPreviewControlsState) !=
          (newState is InitialPreviewControlsState),
      builder: (context, state) {
        if (state is InitialPreviewControlsState) {
          return SizedBox.shrink();
        } else {
          final controller = (state as VideoPlayerPreviewState).controller;
          return VideoPreviewWidget(controller);
        }
      },
    );
  }

  Widget buildControls() {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        if (state is VideoPlayerPreviewState) {
          final controller = state.controller;
          if (state is StoppedPreviewState) {
            if (state.firstTime) {
              return buildFirstTimePreviewControls();
            } else {
              return buildPreviewControls();
            }
          } else if (state is PlayingPreviewState) {
            return buildPlayingPreviewControls(controller);
          }
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget buildFirstTimePreviewControls() {
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
                    onTap: (_) => _bloc.dispatch(PlayPreviewEvent()),
                  ),
                ))),
      ],
    );
  }

  Widget buildPreviewControls() {
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
                    onTap: (context) => Navigator.pop(context),
                  )),
              Center(
                child: TextButton(
                  text: "Play",
                  onTap: (context) => _bloc.dispatch(PlayPreviewEvent()),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    text: "Submit",
                    onTap: (context) {
                      BlocProvider.of<AwsUploadBloc>(context)
                          .dispatch(StartAwsUploadEvent(videoLink));
                      Navigator.pop(context);
                    },
                  )),
            ],
          )),
    );
  }

  Widget buildPlayingPreviewControls(VideoPlayerController controller) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.fromSize(
        size: Size.fromHeight(rowHeight),
        child: Container(
          color: defaultBackground,
          child: Stack(
            children: <Widget>[
              VideoProgressWidget(
                controller,
                onComplete: () => _bloc.dispatch(ResetPreviewEvent()),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        text: "Skip",
                        onTap: (context) => _bloc.dispatch(ResetPreviewEvent()),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispatch(DisposePreviewEvent());
    super.dispose();
  }
}
