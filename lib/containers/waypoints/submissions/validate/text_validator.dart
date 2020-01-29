import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/variant_validator.dart';

class TextValidator extends Validator {
  final EmptyValidator _emptyValidator;
  final VariantValidator _variantValidator;

  TextValidator({String emptyTextError, String invalidError})
      : _emptyValidator = EmptyValidator(error: emptyTextError),
        _variantValidator = VariantValidator(error: invalidError),
        super();

  @override
  String validate(input, {variants}) {
    return ((variants == null) ? _emptyValidator : _variantValidator)
        .validate(input, variants: variants);
  }
}
