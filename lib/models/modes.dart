import './features.dart';
import './rules.dart';
import './sorting.dart';

class RouteMode {
  String name;
  String title;
  String icon;
  String type;
  Features features;
  List<Rules> rules;
  Sorting sorting;
  List<String> categories;

  RouteMode();

  RouteMode.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        title = map["title"],
        icon = map["icon"],
        type = map["type"],
        features = map.containsKey("features")
            ? Features.fromJsonMap(map["features"])
            : null,
        rules = map["rules"] != null
            ? List<Rules>.from(map["rules"].map((it) => Rules.fromJsonMap(it)))
            : List(),
        sorting =
            map["sorting"] != null ? Sorting.fromJsonMap(map["sorting"]) : null,
        categories = map["categories"] != null
            ? List<String>.from(map["categories"])
            : List();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['title'] = title;
    data['icon'] = icon;
    data['type'] = type;
    data['features'] = features == null ? null : features.toJson();
    data['rules'] =
        rules != null ? this.rules.map((v) => v.toJson()).toList() : null;
    data['sorting'] = sorting == null ? null : sorting.toJson();
    data['categories'] = categories;
    return data;
  }

  RouteMode.home()
      : name = "home",
        title = "home",
        icon = "home",
        type = "home";

  RouteMode.menu()
      : name = "menu",
        title = "menu",
        icon = "menu",
        type = "menu";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RouteMode &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;
}
