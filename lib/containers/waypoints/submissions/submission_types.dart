enum SubmissionType { text, photo }

class SubmissionTypeHelper {
  static SubmissionType fromString(String value) {
    return SubmissionType.values.firstWhere((e) {
      return e.toString() == "SubmissionType.$value";
    }, orElse: () => null); //return null if not found
  }
}
