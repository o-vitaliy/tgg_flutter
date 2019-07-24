import './step.dart';

class Defaults {

  int points;
  int max_teams;
  Step step;

	Defaults.fromJsonMap(Map<String, dynamic> map): 
		points = map["points"],
		max_teams = map["max_teams"],
		step = Step.fromJsonMap(map["step"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['points'] = points;
		data['max_teams'] = max_teams;
		data['step'] = step == null ? null : step.toJson();
		return data;
	}
}
