abstract class AnswerTransformer<T> {
  T transform(answer);
}

class StringTransformer extends AnswerTransformer<String> {
  @override
  String transform(answer) {
    return answer.toString();
  }
}

class ListStringTransformer extends AnswerTransformer<List<String>> {
  @override
  List<String> transform(answer) {
    return answer
        .toString()
        .split(",")
        .map((v) => v.trim())
        .toList(growable: false);
  }
}

class BooleanTransformer extends AnswerTransformer<bool> {
  @override
  bool transform(answer) {
    if (answer == null) {
      return false;
    } else if (answer is bool) {
      return answer;
    } else if (answer is num) {
      return answer > 0;
    } else if (answer is String) {
      return answer == "true";
    } else {
      throw ArgumentError("unsuported type of answer $answer");
    }
  }
}
