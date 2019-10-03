import './content.dart';

class Step {
  String behaviorName;
  Content content;

  Step.fromJsonMap(Map<String, dynamic> map)
      : behaviorName = map["behavior_name"],
        content = Content.fromJsonMap(map["content"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['behavior_name'] = behaviorName;
    data['content'] = content == null ? null : content.toJson();
    return data;
  }
}
