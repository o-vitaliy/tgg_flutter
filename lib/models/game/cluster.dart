
class Cluster {

  String sort;
  bool hasLocation;
  bool isNearby;

	Cluster.fromJsonMap(Map<String, dynamic> map): 
		sort = map["sort"],
		hasLocation = map["has_location"],
		isNearby = map["is_nearby"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sort'] = sort;
		data['has_location'] = hasLocation;
		data['is_nearby'] = isNearby;
		return data;
	}
}
