class Rules {
  String category;
  bool allowRepeat;
  int max;
  String sort;
  bool enabled;
  bool timer;

  Rules.fromJsonMap(Map<String, dynamic> map)
      : category = map["category"],
        allowRepeat = map["allow_repeat"],
        max = map["max"],
        sort = map["sort"],
        enabled = map["enabled"],
        timer = map["timer"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = category;
    data['allow_repeat'] = allowRepeat;
    data['max'] = max;
    data['sort'] = sort;
    data['enabled'] = enabled;
    data['timer'] = timer;
    return data;
  }
}
