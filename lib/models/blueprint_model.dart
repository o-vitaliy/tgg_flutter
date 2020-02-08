class BlueprintModel {
  String name;
  String title;
  int version;
  int duration;

  BlueprintModel.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        title = map["title"],
        version = map["version"],
        duration = map["duration"];
}
