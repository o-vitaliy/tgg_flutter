import 'package:tgg/helpers/map_utils.dart';

int getIntValue(Map<String, Object> step, String key) {
  return getValue(step, key, (v) => v is int ? v : int.tryParse(v));
}

bool getBoolValue(Map<String, Object> step, String key) {
  return getValue(step, key, (v) => v is bool ? v : v == "true") ?? false;
}

String getStringValue(Map<String, Object> step, String key) {
  return getValue(step, key, (v) => v);
}

T getValue<T>(
  Map<String, Object> step,
  String key,
  T Function(dynamic v) transformer,
) {
  final value = getAt(step, "content.$key");
  if (value != null) return transformer(value);
  final fieldValue = _getField(key, "default", step);
  return fieldValue != null ? fieldValue as T : null;
}

dynamic _getField(String key, String valueKey, Map<String, Object> step) {
  final List fields = getAt(step, "behavior.fields");
  final value = fields != null
      ? fields.firstWhere((field) => field["name"] == key, orElse: () => null)
      : null;
  if (value != null) {
    return value[valueKey];
  }
  return null;
}
