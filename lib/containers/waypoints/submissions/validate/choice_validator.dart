import 'package:tgg/models/waypoints/submission_choice.dart';

import 'validator.dart';

const defaultChoiceError = "Field shoud not be empty";

class ChoiceValidator extends Validator {
  final String error;

  ChoiceValidator({String error}) : this.error = error ?? defaultChoiceError;

  @override
  String validate(String input, {variants}) {
    List<SubmissionChoice> choices = variants;
    return choices.firstWhere((c) => c.correct).value == input ? null : error;
  }
}
