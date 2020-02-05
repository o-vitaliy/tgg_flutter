import 'package:meta/meta.dart';

@immutable
class SubmissionChoice {
  final String text;
  final value;

  SubmissionChoice._fromMap(Map<String, dynamic> map)
      : text = map["text"],
        value = map["value"];

  static List<SubmissionChoice> from(map) {
    if (map == null) return null;
    List<SubmissionChoice> results = List();

    if (map is List) {
      results.addAll(map.expand((m) => from(m)));
    } else {
      try {
        results.add(SubmissionChoice._fromMap(map));
      } catch (e) {
        print(e);
      }
    }

    return results;
  }
}
