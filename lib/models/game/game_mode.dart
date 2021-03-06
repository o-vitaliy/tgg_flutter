import 'package:tgg/models/game/features.dart';
import 'package:tgg/models/game/rules.dart';
import 'package:tgg/models/game/sorting.dart';

class GameMode {
  String category;
  String name;
  String title;
  bool enabled;
  String source;
  String type;
  String icon;
  int delay;
  int maxTotal;
  int maxPerTeam;
  Sorting sorting;
  Features features;
  List<String> categories;
  List<Rules> rules;

  GameMode.fromJsonMap(Map<String, dynamic> map)
      : category = map["category"],
        name = map["name"],
        title = map["title"],
        enabled = map["enabled"],
        source = map["source"],
        type = map["type"],
        icon = map["icon"],
        delay = map["delay"],
        maxTotal = map["max_total"],
        maxPerTeam = map["max_per_team"],
        sorting = map.containsKey("sorting")
            ? Sorting.fromJsonMap(map["sorting"])
            : null,
        features = map.containsKey("features")
            ? Features.fromJsonMap(map["features"])
            : null,
        categories = map.containsKey("categories")
            ? List<String>.from(map["categories"])
            : List(),
        rules = map.containsKey("rules")
            ? List<Rules>.from(map["rules"].map((it) => Rules.fromJsonMap(it)))
            : List();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
    data['name'] = name;
    data['title'] = title;
    data['enabled'] = enabled;
    data['source'] = source;
    data['type'] = type;
    data['icon'] = icon;
    data['delay'] = delay;
    data['max_total'] = maxTotal;
    data['max_per_team'] = maxPerTeam;
    data['sorting'] = sorting == null ? null : sorting.toJson();
    data['features'] = features == null ? null : features.toJson();
    data['categories'] = categories;
    data['rules'] =
        rules != null ? this.rules.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
