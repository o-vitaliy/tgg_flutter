enum SubmissionType { text, photo, number, choice, movie, checkboxes, camera }

class SubmissionTypeHelper {
  static SubmissionType fromString(String value) {
    return SubmissionType.values.firstWhere((e) {
      return e.toString() == "SubmissionType.$value";
    },
        orElse: () => throw ArgumentError(
            "unsupported type $value")); //throws error if not found
  }

  static bool isMedia(SubmissionType type) {
    switch (type) {
      case SubmissionType.photo:
      case SubmissionType.movie:
      case SubmissionType.camera:
        return true;
      case SubmissionType.text:
      case SubmissionType.number:
      case SubmissionType.choice:
      case SubmissionType.checkboxes:
        return false;

      default:
        throw ArgumentError("unsupported type $type");
    }
  }

  static bool isMultiChoice(SubmissionType type) {
    switch (type) {
      case SubmissionType.choice:
      case SubmissionType.checkboxes:
        return true;
      case SubmissionType.photo:
      case SubmissionType.movie:
      case SubmissionType.camera:
      case SubmissionType.text:
      case SubmissionType.number:
        return false;

      default:
        throw ArgumentError("unsupported type $type");
    }
  }

  static bool isMediaFromString(String type) {
    return isMedia(fromString(type));
  }
}
