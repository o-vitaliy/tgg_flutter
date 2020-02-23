enum Mode { main, anytime, camera }

class ModeHelper {
  static Mode fromString(String name) {
    return Mode.values.firstWhere((e) {
      return e.toString() == "Mode.$name";
    },
        orElse: () => throw ArgumentError(
            "unsupported type $name")); //throws error if not found
  }

  static String to(Mode mode) {
    return mode.toString().split(".")[1];
  }

  static bool removeOnDuplicatedInState(Mode mode) {
    return mode != Mode.main;
  }
}
