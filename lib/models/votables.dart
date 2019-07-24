
class Votables {

  Object max;

	Votables.fromJsonMap(Map<String, dynamic> map): 
		max = map["max"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['max'] = max;
		return data;
	}
}
