import 'package:tgg/models/game/game_mode.dart';
import 'package:tgg/models/game/options.dart';
import 'package:tgg/models/game/variables.dart';

class Game {
  Object city_id;
  bool is_archived;
  String team_gated_message;
  String updated_at;
  String updated_by_id;
  Object end_venue;
  String id;
  String ended_early_message;
  List<String> flavors;
  String last_ran_by_id;
  int hubspot_deal_id;
  String title;
  Object info_message;
  Options options;
  Object center_location;
  Object notes;
  Object legacy_id;
  Variables variables;
  String blueprint_name;
  List<Object> hull;
  String organization_id;
  String last_ran_at;
  String name;
  String created_at;
  String welcome_message;
  Object gamezone_id;
  Object flavor_name;
  String created_by_id;
  Object start_venue;
  String ended_message;
  List<GameMode> gameModes;

  Game.fromJsonMap(Map<String, dynamic> map)
      : city_id = map["city_id"],
        is_archived = map["is_archived"],
        team_gated_message = map["team_gated_message"],
        updated_at = map["updated_at"],
        updated_by_id = map["updated_by_id"],
        end_venue = map["end_venue"],
        id = map["id"],
        ended_early_message = map["ended_early_message"],
        flavors = List<String>.from(map["flavors"]),
        last_ran_by_id = map["last_ran_by_id"],
        hubspot_deal_id = map["hubspot_deal_id"],
        title = map["title"],
        info_message = map["info_message"],
        options = Options.fromJsonMap(map["options"]),
        center_location = map["center_location"],
        notes = map["notes"],
        legacy_id = map["legacy_id"],
        variables = Variables.fromJsonMap(map["variables"]),
        blueprint_name = map["blueprint_name"],
        hull = map["hull"],
        organization_id = map["organization_id"],
        last_ran_at = map["last_ran_at"],
        name = map["name"],
        created_at = map["created_at"],
        welcome_message = map["welcome_message"],
        gamezone_id = map["gamezone_id"],
        flavor_name = map["flavor_name"],
        created_by_id = map["created_by_id"],
        start_venue = map["start_venue"],
        ended_message = map["ended_message"],
        gameModes = List<GameMode>.from(
            map["routing"]["modes"].map((it) => GameMode.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = city_id;
    data['is_archived'] = is_archived;
    data['team_gated_message'] = team_gated_message;
    data['updated_at'] = updated_at;
    data['updated_by_id'] = updated_by_id;
    data['end_venue'] = end_venue;
    data['id'] = id;
    data['ended_early_message'] = ended_early_message;
    data['flavors'] = flavors;
    data['last_ran_by_id'] = last_ran_by_id;
    data['hubspot_deal_id'] = hubspot_deal_id;
    data['title'] = title;
    data['info_message'] = info_message;
    data['options'] = options == null ? null : options.toJson();
    data['center_location'] = center_location;
    data['notes'] = notes;
    data['legacy_id'] = legacy_id;
    data['variables'] = variables == null ? null : variables.toJson();
    data['blueprint_name'] = blueprint_name;
    data['hull'] = hull;
    data['organization_id'] = organization_id;
    data['last_ran_at'] = last_ran_at;
    data['name'] = name;
    data['created_at'] = created_at;
    data['welcome_message'] = welcome_message;
    data['gamezone_id'] = gamezone_id;
    data['flavor_name'] = flavor_name;
    data['created_by_id'] = created_by_id;
    data['start_venue'] = start_venue;
    data['ended_message'] = ended_message;
    return data;
  }
}
