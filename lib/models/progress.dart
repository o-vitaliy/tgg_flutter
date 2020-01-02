
class Progress {

  int points;

	Progress.fromJsonMap(Map<String, dynamic> map): 
		points = map["points"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['points'] = points;
		return data;
	}
}
