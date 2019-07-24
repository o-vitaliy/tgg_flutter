import './variables.dart';
import './roles.dart';
import './routing.dart';
import './categories.dart';

class BlueprintModel {

  String name;
  String title;
  int version;
  int duration;
  List<Variables> variables;
  String category_default;
  List<Roles> roles;
  Routing routing;
  List<Categories> categories;

	BlueprintModel.fromJsonMap(Map<String, dynamic> map):
		name = map["name"],
		title = map["title"],
		version = map["version"],
		duration = map["duration"],
		variables = List<Variables>.from(map["variables"].map((it) => Variables.fromJsonMap(it))),
		category_default = map["category_default"],
		roles = map["roles"]!=null ? List<Roles>.from(map["roles"].map((it) => Roles.fromJsonMap(it))) :List(),
		routing = Routing.fromJsonMap(map["routing"]),
		categories = List<Categories>.from(map["categories"].map((it) => Categories.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['title'] = title;
		data['version'] = version;
		data['duration'] = duration;
		data['variables'] = variables != null ?
			this.variables.map((v) => v.toJson()).toList()
			: null;
		data['category_default'] = category_default;
		/*data['roles'] = roles != null ?
			this.roles.map((v) => v.toJson()).toList()
			: null;*/
		data['routing'] = routing == null ? null : routing.toJson();
		data['categories'] = categories != null ?
			this.categories.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
