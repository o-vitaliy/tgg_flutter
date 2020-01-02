import './routing.dart';
import 'game/variables.dart';

class BlueprintModel {
  String name;
  String title;
  int version;
  int duration;

  List<Variables> variables;

  // String category_default;
  // List<Roles> roles;
  Routing routing;

  // List<Categories> categories;

  BlueprintModel.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        title = map["title"],
        version = map["version"],
        duration = map["duration"],
        variables = getVariables(map),
  //	category_default = map["category_default"],
  //	roles = map["roles"]!=null ? List<Roles>.from(map["roles"].map((it) => Roles.fromJsonMap(it))) :List(),
        routing = Routing.fromJsonMap(map["routing"]);


  static List<Variables> getVariables(Map<String, dynamic> map) {
    final v = map["variables"];
    if (v != null) {
      return List<Variables>.from(map["variables"].map((it) => Variables.fromJsonMap(it)));
    } else {
      return List<Variables>();
    }
  }
}
