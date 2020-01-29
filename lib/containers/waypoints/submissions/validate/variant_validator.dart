import 'package:tgg/helpers/levenshtein.dart';

import 'validator.dart';

const defaultChoiceError = "Incorrect value";

const _threshold = 0.1;

class VariantValidator extends Validator {
  final String error;

  VariantValidator({String error}) : this.error = error ?? defaultChoiceError;

  @override
  String validate(input, {variants}) {
    if (input == null) return error;
    final List<String> correctVariants = List<String>.from(variants);

    final distances = correctVariants
        .map((variant) =>
            normalizedDistance(variant, input, caseSensitive: false))
        .where((d) => d <= _threshold);

    return distances.length > 0 ? null : error;
  }
}
