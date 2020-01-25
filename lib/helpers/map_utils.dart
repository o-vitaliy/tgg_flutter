Map<String, Object> merge(
    Map<String, Object> source, Map<String, Object> overriding) {
  source = convert(source);
  overriding = convert(overriding);
  overriding.keys.forEach((key) {
    if (overriding[key] is Map) {
      final tmp =
          Map.of(merge(source[key] ?? Map<String, Object>(), overriding[key]));
      source[key] = tmp;
    } else {
      source[key] = overriding[key];
    }
  });
  return source;
}

Map<String, Object> convert(Map<String, Object> source) {
  final Map<String, Object> result = Map<String, Object>();
  source.keys.forEach((key) {
    result[key] = source[key];
  });

  return result;
}

dynamic getAt(Map<String, Object> source, String path,
    {String delimiter = "."}) {
  if (source == null) return null;
  if (path == null) return null;

  String first = path.split(delimiter).first;
  if (source.containsKey(first)) {
    final value = source[first];

    if (first.length + delimiter.length >= path.length) {
      return value;
    } else if (value is Map) {
      final nextPath = path.substring(first.length + delimiter.length);
      return getAt(value, nextPath, delimiter: delimiter);
    } else {
      return null;
    }
  } else {
    return null;
  }
}
