import './content.dart';

class Step {

  String behavior_name;
  Content content;

	Step.fromJsonMap(Map<String, dynamic> map): 
		behavior_name = map["behavior_name"],
		content = Content.fromJsonMap(map["content"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['behavior_name'] = behavior_name;
		data['content'] = content == null ? null : content.toJson();
		return data;
	}
}
