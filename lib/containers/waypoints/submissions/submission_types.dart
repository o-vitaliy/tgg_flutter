enum SubmissionType { text, photo, number, choice, movie }

class SubmissionTypeHelper {
  static SubmissionType fromString(String value) {
    return SubmissionType.values.firstWhere((e) {
      return e.toString() == "SubmissionType.$value";
    }, orElse: () => null); //return null if not found
  }

  static bool isMedia(SubmissionType type) {
    switch (type) {
      case SubmissionType.photo:
      case SubmissionType.movie:
        return true;
      case SubmissionType.text:
      case SubmissionType.number:
      case SubmissionType.choice:
        return false;

      default:
        throw ArgumentError("unsupported type $type");
    }
  }

  static bool isMediaFromString(String type) {
    return isMedia(fromString(type));
  }
}
