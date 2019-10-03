import './defaults.dart';

class Categories {
  String icon;
  String name;
  String title;
  bool displayPercentCorrect;
  Defaults defaults;
  int directPriority;

  Categories.fromJsonMap(Map<String, dynamic> map)
      : icon = map["icon"],
        name = map["name"],
        title = map["title"],
        displayPercentCorrect = map["display_percent_correct"],
        defaults = Defaults.fromJsonMap(map["defaults"]),
        directPriority = map["direct_priority"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['icon'] = icon;
    data['name'] = name;
    data['title'] = title;
    data['display_percent_correct'] = displayPercentCorrect;
    data['defaults'] = defaults == null ? null : defaults.toJson();
    data['direct_priority'] = directPriority;
    return data;
  }
}
