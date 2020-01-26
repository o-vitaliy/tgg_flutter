import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';

class RecordStartStopButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onRecordClick;
  final VoidCallback onStopClick;

  const RecordStartStopButton(
      {Key key,
      @required this.isRecording,
      @required this.onRecordClick,
      @required this.onStopClick})
      : assert(isRecording != null),
        assert(onRecordClick != null),
        assert(onStopClick != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSquareIconButton(
      icon: isRecording
          ? FontAwesomeIcons.solidStopCircle
          : FontAwesomeIcons.solidPlayCircle,
      onTap: (c) => isRecording ? onStopClick() : onRecordClick(),
    );
  }
}

class RecordStartPauseButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onRecordClick;
  final VoidCallback onPauseClick;

  const RecordStartPauseButton(
      {Key key,
      @required this.isRecording,
      @required this.onRecordClick,
      @required this.onPauseClick})
      : assert(isRecording != null),
        assert(onRecordClick != null),
        assert(onPauseClick != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(0, 0, 0, 0),
      child: GestureDetector(
        onTapDown: (_) => onRecordClick(),
        onTapUp: (_) => onPauseClick(),
        child: SizedBox.fromSize(
          size: Size.square(58),
          child: Icon(
            isRecording
                ? FontAwesomeIcons.solidPauseCircle
                : FontAwesomeIcons.solidPlayCircle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TakePhotoButton extends StatelessWidget {
  final VoidCallback onTakePhotoClick;

  const TakePhotoButton({Key key, this.onTakePhotoClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSquareIconButton(
      icon: FontAwesomeIcons.camera,
      onTap: (c) => onTakePhotoClick(),
    );
  }
}
