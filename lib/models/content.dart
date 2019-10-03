class Content {
  int timelimit;

  Content.fromJsonMap(Map<String, dynamic> map) : timelimit = map["timelimit"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['timelimit'] = timelimit;
    return data;
  }
}
