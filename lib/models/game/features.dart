
class Features {

  int route_ahead;

	Features.fromJsonMap(Map<String, dynamic> map): 
		route_ahead = map["route_ahead"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['route_ahead'] = route_ahead;
		return data;
	}
}
