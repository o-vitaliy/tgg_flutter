class ValidationResult {
  final bool isValid;
  final incorrectAnswer;

  ValidationResult(this.isValid, this.incorrectAnswer);

  factory ValidationResult.init(any, incorrectAnswer) {
    return ValidationResult(any == null, incorrectAnswer);
  }
}
