import 'package:tgg/containers/waypoints/submissions/widget/take_photo_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/text_widget.dart';

import '../submission_types.dart';
import 'value_widget.dart';

ValueWidget build(
  SubmissionType type,
  String initialValue,
  String error,
  OnValueChange onValueChange,
  OnSubmit onSubmit,
) {
  switch (type) {
    case SubmissionType.text:
      return TextWidget(onValueChange, onSubmit, initialValue, error);
    case SubmissionType.photo:
      return TakePhotoWidget(onValueChange, onSubmit, initialValue, error);
    default:
      throw ArgumentError("unsupported type $type");
  }
}
