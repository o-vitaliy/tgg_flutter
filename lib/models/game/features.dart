class Features {
  int routeAhead;

  Features.fromJsonMap(Map<String, dynamic> map)
      : routeAhead = map["route_ahead"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['route_ahead'] = routeAhead;
    return data;
  }
}
