class BlueprintModel {
  final String id;
  final String title;
  final int version;
  final int duration;

  BlueprintModel.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        version = map["version"],
        duration = map["duration"];
}
