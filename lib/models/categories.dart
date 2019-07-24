import './defaults.dart';

class Categories {

  String icon;
  String name;
  String title;
  bool display_percent_correct;
  Defaults defaults;
  int direct_priority;

	Categories.fromJsonMap(Map<String, dynamic> map): 
		icon = map["icon"],
		name = map["name"],
		title = map["title"],
		display_percent_correct = map["display_percent_correct"],
		defaults = Defaults.fromJsonMap(map["defaults"]),
		direct_priority = map["direct_priority"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = icon;
		data['name'] = name;
		data['title'] = title;
		data['display_percent_correct'] = display_percent_correct;
		data['defaults'] = defaults == null ? null : defaults.toJson();
		data['direct_priority'] = direct_priority;
		return data;
	}
}
