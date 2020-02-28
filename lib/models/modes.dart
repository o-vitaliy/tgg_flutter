class RouteMode {
  final String name;
  final String title;
  final String icon;
  final String type;
  final bool enabled;
  final Duration delay;
  final int maxTotal;

  bool locked = false;

  RouteMode.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        title = map["title"],
        icon = map["icon"],
        type = map["type"],
        enabled = map["enabled"] ?? true,
        delay = map["delay"] != null ? Duration(minutes: map["delay"]) : null,
        maxTotal = map["max_total"];

  RouteMode.home()
      : name = "home",
        title = "home",
        icon = "home",
        type = "home",
        enabled = true,
        delay = null,
        maxTotal = null;

  RouteMode.menu()
      : name = "menu",
        title = "menu",
        icon = "menu",
        type = "menu",
        enabled = true,
        delay = null,
        maxTotal = null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteMode &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
