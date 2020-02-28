import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

const _iterableSign = "{n}";

const tryAgainText = "mission:incorrect:tryagain:{n}:text";
const tryAgainImage = "mission:incorrect:tryagain:{n}:image";
const missionCorrectText = "mission:correct:{n}:text";
const missionCorrectImage = "mission:correct:{n}:image";
const missionCodeOk = "mission:code:ok";
const messageOk = "message:ok";

class Flavor {
  final Map<String, dynamic> values;

  Flavor._(this.values);

  bool contains(String key) => values.containsKey(key);

  String get(String key, {Map<String, dynamic> params}) =>
      applyParams(values[key] ?? key, params);

  TinyColor color(String key) {
    final String value = values[key];
    if (value != null) {
      return TinyColor.fromString(value);
    }
    return null;
  }

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
      text = text.replaceFirst("{{$key}}", value.toString());
    });
    return text;
  }

  factory Flavor.initial() {
    return Flavor._(Map<String, dynamic>());
  }

  static Flavor create(Map<String, dynamic> values) {
    return Flavor._(values);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Flavor &&
          runtimeType == other.runtimeType &&
          values == other.values;

  @override
  int get hashCode => values?.length ?? 0;
}
