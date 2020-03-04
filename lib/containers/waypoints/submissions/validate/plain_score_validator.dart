import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';

const _defaultError = "Incorrect value";

class PlainScoreValidator extends Validator {
  final String error;

  PlainScoreValidator({String error}) : this.error = error ?? _defaultError;

  @override
  String validate(input, {variants}) {
    final String password = input;
    return List<String>.from(variants).contains(password) ? null : error;
  }
}
