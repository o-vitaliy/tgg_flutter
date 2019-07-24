
class Variables {

  String name;
  String title;

	Variables.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		title = map["title"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['title'] = title;
		return data;
	}
}
