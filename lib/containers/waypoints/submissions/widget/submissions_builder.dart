import 'package:flutter/material.dart';

import '../submission_types.dart';
import 'camera_widget.dart';
import 'checkbox_widget.dart';
import 'number_widget.dart';
import 'radio_widget.dart';
import 'take_photo_widget.dart';
import 'take_video_widget.dart';
import 'text_widget.dart';
import 'value_widget.dart';

Widget build(
    SubmissionType type, OnValueChange onValueChange, OnSubmit onSubmit,
    {value, variants}) {
  switch (type) {
    case SubmissionType.text:
      return TextWidget(onValueChange, onSubmit, value, key: ValueKey(type));
    case SubmissionType.photo:
      return TakePhotoWidget(onValueChange, onSubmit, value,
          key: ValueKey(type));
    case SubmissionType.number:
      return NumberWidget(onValueChange, onSubmit, value, key: ValueKey(type));
    case SubmissionType.choice:
      return RadioWidget(onValueChange, onSubmit, value, variants,
          key: ValueKey(type));
    case SubmissionType.checkboxes:
      return CheckboxWidget(onValueChange, onSubmit, value, variants,
          key: ValueKey(type));
    case SubmissionType.movie:
      return TakeVideoWidget(onValueChange, onSubmit, value,
          key: ValueKey(type));
    case SubmissionType.camera:
      return CameraWidget(onValueChange, onSubmit, value, key: ValueKey(type));
    default:
      throw ArgumentError("unsupported type $type");
  }
}
