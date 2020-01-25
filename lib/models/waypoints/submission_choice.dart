import 'package:meta/meta.dart';

@immutable
class SubmissionChoice {
  final String value;
  final bool correct;

  SubmissionChoice._fromMap(Map<String, dynamic> map)
      : value = map["text"],
        correct = map["value"];

  static List<SubmissionChoice> from(map) {
    if (map == null) return null;
    List<SubmissionChoice> results = List();

    if (map is List) {
      results.addAll(map.expand((m) => from(m)));
    } else {
      results.add(SubmissionChoice._fromMap(map));
    }

    return results;
  }
}
