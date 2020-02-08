import './modes.dart';

class Routing {
  int version;
  List<RouteMode> modes;

  Routing.fromJsonMap(Map<String, dynamic> map)
      : version = map["version"],
        modes = map["modes"] != null
            ? List<RouteMode>.from(
            map["modes"].map((it) => RouteMode.fromJsonMap(it)))
            : List<RouteMode>();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['version'] = version;
    data['modes'] =
        modes != null ? this.modes.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
