
class Cluster {

  bool has_location;
  bool is_nearby;
  String sort;

	Cluster.fromJsonMap(Map<String, dynamic> map): 
		has_location = map["has_location"],
		is_nearby = map["is_nearby"],
		sort = map["sort"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['has_location'] = has_location;
		data['is_nearby'] = is_nearby;
		data['sort'] = sort;
		return data;
	}
}
