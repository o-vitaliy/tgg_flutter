import './step.dart';

class Defaults {

  int points;
  int maxTeams;
  Step step;

	Defaults.fromJsonMap(Map<String, dynamic> map): 
		points = map["points"],
		maxTeams = map["max_teams"],
		step = Step.fromJsonMap(map["step"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['points'] = points;
		data['max_teams'] = maxTeams;
		data['step'] = step == null ? null : step.toJson();
		return data;
	}
}
