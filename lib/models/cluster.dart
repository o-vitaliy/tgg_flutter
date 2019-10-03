class Cluster {
  bool hasLocation;
  bool isNearby;
  String sort;

  Cluster.fromJsonMap(Map<String, dynamic> map)
      : hasLocation = map["has_location"],
        isNearby = map["is_nearby"],
        sort = map["sort"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['has_location'] = hasLocation;
    data['is_nearby'] = isNearby;
    data['sort'] = sort;
    return data;
  }
}
