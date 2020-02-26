class RouteMode {
  final String name;
  final String title;
  final String icon;
  final String type;
  final bool enabled;

  RouteMode.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        title = map["title"],
        icon = map["icon"],
        type = map["type"],
        enabled = map["enabled"] ?? true;

  RouteMode.home()
      : name = "home",
        title = "home",
        icon = "home",
        type = "home",
        enabled = true;

  RouteMode.menu()
      : name = "menu",
        title = "menu",
        icon = "menu",
        type = "menu",
        enabled = true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteMode &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
