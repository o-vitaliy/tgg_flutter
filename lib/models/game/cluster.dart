
class Cluster {

  String sort;
  bool has_location;
  bool is_nearby;

	Cluster.fromJsonMap(Map<String, dynamic> map): 
		sort = map["sort"],
		has_location = map["has_location"],
		is_nearby = map["is_nearby"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sort'] = sort;
		data['has_location'] = has_location;
		data['is_nearby'] = is_nearby;
		return data;
	}
}
