import './features.dart';
import './rules.dart';
import './sorting.dart';

class Modes {

  String name;
  String title;
  String icon;
  String type;
  Features features;
  List<Rules> rules;
  Sorting sorting;
  List<String> categories;

	Modes.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		title = map["title"],
		icon = map["icon"],
		type = map["type"],
		features = map["features"] ? Features.fromJsonMap(map["features"]) : List(),
		rules = List<Rules>.from(map["rules"].map((it) => Rules.fromJsonMap(it))),
		sorting = Sorting.fromJsonMap(map["sorting"]),
		categories = List<String>.from(map["categories"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['title'] = title;
		data['icon'] = icon;
		data['type'] = type;
		data['features'] = features == null ? null : features.toJson();
		data['rules'] = rules != null ? 
			this.rules.map((v) => v.toJson()).toList()
			: null;
		data['sorting'] = sorting == null ? null : sorting.toJson();
		data['categories'] = categories;
		return data;
	}
}
