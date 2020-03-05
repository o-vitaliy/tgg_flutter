import 'package:tgg/common/blueprint/blueprint_reducer.dart';
import 'package:tgg/common/flavor/flavor_reducer.dart';
import 'package:tgg/common/playthrought/playthrought_reducer.dart';
import 'package:tgg/common/routing/routing_reducer.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_reducer.dart';
import 'package:tgg/containers/h2h/h2h_reducer.dart';
import 'package:tgg/containers/login/login_reducer.dart';
import 'package:tgg/containers/mission/anytime/anytime_reducer.dart';
import 'package:tgg/containers/mission/bonus/bonus_reducer.dart';
import 'package:tgg/containers/points/points_reducer.dart';
import 'package:tgg/containers/team/team_reducer.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_reducer.dart';
import 'package:tgg/containers/waypoints/waypoints_reducer.dart';
import 'package:tgg/reducers/post_location_reducer.dart';
import 'package:tgg/redux_model/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    team: teamReducer(state.team, action),
    playthrough: playthoughReducer(state.playthrough, action),
    postLocationTimer: postLocationReducer(state.postLocationTimer, action),
    loginState: loginReducer(state.loginState, action),
    homePageState: routingReducer(state.homePageState, action),
    uploadFilesState: awsUploadFilesReducer(state.uploadFilesState, action),
    waypointsState: waypointsReducer(state.waypointsState, action),
    waypointsPassingState: waypointReducer(state.waypointsPassingState, action),
    flavor: flavorReducer(state.flavor, action),
    blueprint: blueprintReducer(state.blueprint, action),
    anytime: anytimeReducer(state.anytime, action),
    bonus: bonusReducer(state.bonus, action),
    h2h: h2hReducer(state.h2h, action),
    points: pointsReducer(state.points, action),
  );
}
