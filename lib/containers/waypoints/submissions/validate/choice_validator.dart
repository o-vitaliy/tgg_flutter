import 'package:quiver/collection.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

import 'validator.dart';

const defaultChoiceError = "Incorrect value";

class CheckboxesValidator extends Validator {
  final String error;

  CheckboxesValidator({String error})
      : this.error = error ?? defaultChoiceError;

  @override
  String validate(input, {variants}) {
    final comparator = (String a, String b) => a.compareTo(b);
    final List<String> result = List<String>.of(input ?? []);
    final List<SubmissionChoice> choices = variants;
    final List<String> correctChoices =
        choices.where((c) => c.value).map((c) => c.text).toList();

    result.sort(comparator);
    correctChoices.sort(comparator);

    return listsEqual(result, correctChoices) ? null : error;
  }
}

class RadioValidator extends Validator {
  final String error;

  RadioValidator({String error}) : this.error = error ?? defaultChoiceError;

  @override
  String validate(input, {variants}) {
    final List<String> correctChoices = List<SubmissionChoice>.of(variants)
        .where((c) => c.value)
        .map((c) => c.text)
        .toList();

    return input != null && correctChoices.contains(input) ? null : error;
  }
}
