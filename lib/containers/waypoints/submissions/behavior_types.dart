enum BehaviorType {
  text_answer,
  text_unverified,
  number_answer,
  number_unverified,
  multiple_choice,
  multiple_choice_points,
  many_choices,
  photo,
  photo_and_text,
  photo_and_text_pair,
  photo_sequence,
  photo_and_text_sequence,
  movie,
  movie_and_text,
  movie_pair,
  camera,

  profile_team_name,
  profile_phone,
  profile_other,
  profile_multiple_choice,
  profile_photo,
}

class BehaviorTypeHelper {
  static BehaviorType fromString(String value) {
    return BehaviorType.values.firstWhere((e) {
      return e.toString() == "BehaviorType.$value";
    },
        orElse: () => throw ArgumentError(
            "unsupported type $value")); //throws error if not found
  }

  static bool isVerified(BehaviorType type) {
    switch (type) {
      case BehaviorType.text_answer:
      case BehaviorType.number_answer:
      case BehaviorType.multiple_choice:
      case BehaviorType.many_choices:
        return true;

      case BehaviorType.text_unverified:
      case BehaviorType.number_unverified:
      case BehaviorType.multiple_choice_points:
      case BehaviorType.many_choices:
      case BehaviorType.photo:
      case BehaviorType.photo_and_text:
      case BehaviorType.photo_and_text_pair:
      case BehaviorType.photo_sequence:
      case BehaviorType.photo_and_text_sequence:
      case BehaviorType.movie:
      case BehaviorType.movie_and_text:
      case BehaviorType.movie_pair:
      case BehaviorType.camera:
      case BehaviorType.profile_team_name:
      case BehaviorType.profile_phone:
      case BehaviorType.profile_other:
      case BehaviorType.profile_multiple_choice:
      case BehaviorType.profile_photo:
        return false;

      default:
        throw ArgumentError("unsupported type $type");
    }
  }
}
