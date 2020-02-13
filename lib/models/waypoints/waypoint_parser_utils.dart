import 'package:tgg/helpers/map_utils.dart';

int getIntValue(step, String key) {
  return getValue(step, key, (v) => int.tryParse(v));
}

bool getBoolValue(step, String key) {
  return getValue(step, key, (v) => v) ?? false;
}

T getValue<T>(step, String key, T Function(dynamic v) transformer) {
  final value = getAt(step, "content.$key");
  if (value != null) return transformer(value);
  final fieldValue = _getField(key, "default", step);
  return fieldValue != null ? fieldValue as T : null;
}

dynamic _getField(String key, String valueKey, step) {
  final List fields = getAt(step, "behavior.fields");
  final value =
      fields.firstWhere((field) => field["name"] == key, orElse: () => null);
  if (value != null) {
    return value[valueKey];
  }
  return null;
}
