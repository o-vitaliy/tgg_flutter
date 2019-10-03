class Rules {
  String category;
  String sort;

  Rules.fromJsonMap(Map<String, dynamic> map)
      : category = map["category"],
        sort = map["sort"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
    data['sort'] = sort;
    return data;
  }
}
