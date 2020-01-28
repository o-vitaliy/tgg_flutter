import 'package:tgg/containers/waypoints/submissions/widget/choice_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/take_video_widget.dart';

import '../submission_types.dart';
import 'number_widget.dart';
import 'take_photo_widget.dart';
import 'text_widget.dart';
import 'value_widget.dart';

ValueWidget build(SubmissionType type, String error,
    OnValueChange onValueChange, OnSubmit onSubmit,
    {value, variants}) {
  switch (type) {
    case SubmissionType.text:
      return TextWidget(onValueChange, onSubmit, value, error);
    case SubmissionType.photo:
      return TakePhotoWidget(onValueChange, onSubmit, value, error);
    case SubmissionType.number:
      return NumberWidget(onValueChange, onSubmit, value, error);
    case SubmissionType.choice:
      return ChoiceWidget(onValueChange, onSubmit, value, error, variants);
    case SubmissionType.movie:
      return TakeVideoWidget(onValueChange, onSubmit, value, error);
    default:
      throw ArgumentError("unsupported type $type");
  }
}
