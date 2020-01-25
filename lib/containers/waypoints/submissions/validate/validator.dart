const defaultEmptyError = "Field shoud not be empty";
const defaultEmailError = "Invalid email";

abstract class Validator {
  String validate(String input);
}

class CompositeValidator extends Validator {
  final String separator;
  final List<Validator> subValidators;

  CompositeValidator(this.separator, this.subValidators);

  @override
  String validate(String input, {variants}) {
    List<String> errors = subValidators
        .map((v) => v.validate(input))
        .where((v) => v != null)
        .toList();

    return errors != null && errors.length > 0 ? errors.join(separator) : null;
  }
}

class EmptyValidator extends Validator {
  final String error;

  EmptyValidator({String error}) : this.error = error ?? defaultEmptyError;

  @override
  String validate(String input) {
    return input == null || input.isEmpty ? error : null;
  }
}

class EmailValidator extends Validator {
  final String error;

  EmailValidator({String error}) : this.error = error ?? defaultEmailError;

  @override
  String validate(String input) {
    return input != null &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(input)
        ? null
        : error;
  }
}

class NumberValidator extends Validator {
  final String error;

  NumberValidator({String error}) : this.error = error ?? defaultEmailError;

  @override
  String validate(String input) {
    return _isNumeric(input) ? null : error;
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }

    if (double.tryParse(s) != null) {
      return true;
    }
    if (int.tryParse(s) != null) {
      return true;
    }

    return false;
  }
}
