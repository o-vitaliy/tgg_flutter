import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behaviors.dart';

const _defaultError = "Incorrect value";

class CodeCustomValidator extends Validator {
  final String error;

  CodeCustomValidator({String error}) : this.error = error ?? _defaultError;

  @override
  String validate(input, {variants}) {
    final List<String> correctChoices = List<String>.from(variants);
    return input != null && correctChoices.contains(input) ? null : error;
  }
}

class CodeStandardValidator extends Validator {

  final CodeCustomValidator codeCustomValidator;

  CodeStandardValidator({String error})
      : codeCustomValidator = CodeCustomValidator(error: error);

  @override
  String validate(input, {variants}) =>
      codeCustomValidator.validate(input, variants: CodeCustomBehaviorType.codes);
}
