
class Content {

  int timelimit;

	Content.fromJsonMap(Map<String, dynamic> map): 
		timelimit = map["timelimit"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['timelimit'] = timelimit;
		return data;
	}
}
