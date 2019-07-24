import './votables.dart';
import './modes.dart';

class Routing {

  int version;
  Votables votables;
  List<Modes> modes;

	Routing.fromJsonMap(Map<String, dynamic> map): 
		version = map["version"],
		votables = Votables.fromJsonMap(map["votables"]),
		modes = List<Modes>.from(map["modes"].map((it) => Modes.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['version'] = version;
		data['votables'] = votables == null ? null : votables.toJson();
		data['modes'] = modes != null ? 
			this.modes.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
