import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'camera.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  @override
  CameraState get initialState => InitialState();

  CameraCaptureMode mode;

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is InitialCameraCaptureEvent) {
      mode = event.mode;
      yield event.mode == CameraCaptureMode.PHOTO
          ? TakePhotoState()
          : VideoRecordingState();
    }
    if (event is CaptureClickEvent) {
      final imagePath = await getImageFileDirectory();
      await event.cameraController.takePicture(imagePath);
      yield PhotoWasTakenState(imagePath);
    }
  }
}

Future<String> getImageFileDirectory() {
  return getApplicationDocumentsDirectory()
      .then((extDir) => '${extDir.path}/Pictures/flutter_test')
      .then((dirPath) => Directory(dirPath).create(recursive: true))
      .then((dir) => '${dir.path}/${timestamp()}.jpg');
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
