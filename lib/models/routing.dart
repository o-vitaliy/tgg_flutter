import './modes.dart';

class Routing {
  final int version;
  final List<RouteMode> modes;

  Routing.fromJsonMap(Map<String, dynamic> map)
      : version = map["version"],
        modes = map["modes"] != null
            ? List<RouteMode>.from(
                map["modes"].map((it) => RouteMode.fromJsonMap(it)))
            : List<RouteMode>();
}
