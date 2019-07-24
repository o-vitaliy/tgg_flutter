
class Roles {

  String name;
  String title;
  List<String> modes;
  bool voting;
  List<String> login_roles;

	Roles.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		title = map["title"],
		modes = List<String>.from(map["modes"]),
		voting = map["voting"],
		login_roles = List<String>.from(map["login_roles"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['title'] = title;
		data['modes'] = modes;
		data['voting'] = voting;
		data['login_roles'] = login_roles;
		return data;
	}
}
