class WaypointSubmission {
  final String type;
  final String defaultPlaceholder;
  final String placeholder;

  WaypointSubmission._({
    this.type,
    this.defaultPlaceholder,
    this.placeholder,
  });

  static List<WaypointSubmission> from(dynamic map) {
    List<WaypointSubmission> result = List();
    if (map is Map) {
      result.add(WaypointSubmission._fromMap(map));
    } else if (map is String) {
      result.add(WaypointSubmission._fromString(map));
    } else if (map is List) {
      result.addAll(map.map((m) => WaypointSubmission._fromString(m)));
    }
    return result;
  }

  static WaypointSubmission _fromMap(Map<String, dynamic> map) {
    return WaypointSubmission._(
        type: map["type"],
        defaultPlaceholder: map["default_placeholder"],
        placeholder: map["placeholder"]);
  }

  static WaypointSubmission _fromString(String type) {
    return WaypointSubmission._(
      type: type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WaypointSubmission &&
              runtimeType == other.runtimeType &&
              type == other.type &&
              defaultPlaceholder == other.defaultPlaceholder &&
              placeholder == other.placeholder;

  @override
  int get hashCode =>
      type.hashCode ^
      defaultPlaceholder.hashCode ^
      placeholder.hashCode;



}
