import '../submission_types.dart';
import 'checkbox_widget.dart';
import 'number_widget.dart';
import 'radio_widget.dart';
import 'take_photo_widget.dart';
import 'take_video_widget.dart';
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
      return RadioWidget(onValueChange, onSubmit, value, error, variants);
    case SubmissionType.checkboxes:
      return CheckboxWidget(onValueChange, onSubmit, value, error, variants);
    case SubmissionType.movie:
      return TakeVideoWidget(onValueChange, onSubmit, value, error);
    default:
      throw ArgumentError("unsupported type $type");
  }
}
