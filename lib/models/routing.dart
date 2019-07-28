import './modes.dart';
import './votables.dart';

class Routing {
  int version;
  Votables votables;
  List<RouteMode> modes;

  Routing.fromJsonMap(Map<String, dynamic> map)
      : version = map["version"],
        votables = Votables.fromJsonMap(map["votables"]),
        modes = map["modes"] != null
            ? List<RouteMode>.from(map["modes"].map((it) => RouteMode.fromJsonMap(it)))
            : List()
  ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = version;
    data['votables'] = votables == null ? null : votables.toJson();
    data['modes'] =
        modes != null ? this.modes.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
