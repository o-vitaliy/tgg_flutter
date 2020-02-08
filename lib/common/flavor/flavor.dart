import 'package:flutter/material.dart';

const _iterableSign = "{n}";

const tryAgainText = "mission:incorrect:tryagain:{n}:text";
const tryAgainImage = "mission:incorrect:tryagain:{n}:text";

class Flavor {
  final Map<String, dynamic> values;

  Flavor._(this.values);

  String get(String key, {Map<String, dynamic> params}) =>
      applyParams(values[key] ?? key, params);

  String iterable(String key, int index, {Map<String, dynamic> params}) {
    if (index < 0) throw ArgumentError("index $index < 0");
    final value = values[key.replaceFirst(_iterableSign, index.toString())];
    return value != null
        ? applyParams(value, params)
        : iterable(key, index - 1, params: params);
  }

  @protected
  @visibleForTesting
  String applyParams(String text, Map<String, dynamic> params) {
    if (params == null) return text;

    params.forEach((key, value) {
      text = text.replaceFirst("{{$key}}", value);
    });
    return text;
  }

  static Flavor initial() {
    return Flavor._(Map<String, dynamic>());
  }

  static Flavor create(Map<String, dynamic> values) {
    return Flavor._(values);
  }
}
