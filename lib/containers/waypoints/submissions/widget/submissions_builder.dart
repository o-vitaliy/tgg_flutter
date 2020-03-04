import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/redirect_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/yesno_widget.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

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
  WaypointSubmissionItem item,
  OnValueChange onValueChange,
  OnSubmit onSubmit,
) {
  final SubmissionType type =
      SubmissionTypeHelper.fromString(item.submission.type);
  final value = item.answer;
  final variants = item.submission.choices;
  switch (type) {
    case SubmissionType.text:
      return TextWidget(
          onValueChange, onSubmit, value, item.submission.placeholder,
          key: ValueKey(type));
    case SubmissionType.photo:
      return TakePhotoWidget(onValueChange, onSubmit, value,
          item.submission.galleryEnabled, item.submission.videoParams,
          key: ValueKey(type));
    case SubmissionType.number:
      return NumberWidget(
          onValueChange, onSubmit, value, item.submission.placeholder,
          key: ValueKey(type));
    case SubmissionType.choice:
      return RadioWidget(onValueChange, onSubmit, value, variants,
          key: ValueKey(type));
    case SubmissionType.checkboxes:
      return CheckboxWidget(onValueChange, onSubmit, value, variants,
          key: ValueKey(type));
    case SubmissionType.movie:
      return TakeVideoWidget(onValueChange, onSubmit, value,
          item.submission.galleryEnabled, item.submission.videoParams,
          key: ValueKey(type));
    case SubmissionType.camera:
      return CameraWidget(onValueChange, onSubmit, value,
          item.submission.galleryEnabled, item.submission.videoParams,
          key: ValueKey(type));
    case SubmissionType.yesno:
      return YesnoWidget(onValueChange, onSubmit, value, variants,
          key: ValueKey(type));
    case SubmissionType.redirect:
      return RedirectWidget(onValueChange, onSubmit, value, variants,
          key: ValueKey(type));
    default:
      throw ArgumentError("unsupported type $type");
  }
}
