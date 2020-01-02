import 'package:flutter/material.dart';

class Keys {
  // Login screen
  static const loginScreen = const Key('__loginScreen__');

  // Home Screens
  static final homeScreen = const Key('__homeScreen__');

  static homeTab(String id) => Key('__homeScreen__tab__${id}__');

  // Camera Screens
  static final cameraPage = const Key('__cameraScreen__');
  static final cameraTorchButton  = const Key('__cameraTorchButton__');
  static final cameraTimer  = const Key('__cameraTimer__');
  static final cameraPreviewScreen = const Key('__cameraPreviewScreen__');

  // Preview Screen
  static final previewPage = const Key('__previvewScreen__');
  static final previewVideoPage = const Key('__previvewVideoScreen__');
  static final previewVideoWidget = const Key('__previvewVideoWidget__');
  static final previewImagePage = const Key('__previvewImageScreen__');
}
