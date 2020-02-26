import 'package:tgg/common/blueprint/blueprint_reducer.dart';
import 'package:tgg/common/flavor/flavor_reducer.dart';
import 'package:tgg/common/playthrought/playthrought_reducer.dart';
import 'package:tgg/common/routing/routing_reducer.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_reducer.dart';
import 'package:tgg/containers/camera/camera_reducer.dart';
import 'package:tgg/containers/h2h/h2h_reducer.dart';
import 'package:tgg/containers/mission/anytime/anytime_reducer.dart';
import 'package:tgg/containers/mission/bonus/bonus_reducer.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_reducer.dart';
import 'package:tgg/containers/waypoints/waypoints_reducer.dart';
import 'package:tgg/containers/team/team_reducer.dart';
import 'package:tgg/reducers/login_reducer.dart';
import 'package:tgg/reducers/post_location_reducer.dart';
import 'package:tgg/reducers/theme_data_reducer.dart';
import 'package:tgg/redux_model/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    themeData: themeDataReducer(state.themeData, action),
    team: teamReducer(state.team, action),
    playthrough: playthoughReducer(state.playthrough, action),
    postLocationTimer: postLocationReducer(state.postLocationTimer, action),
    loginState: loginReducer(state.loginState, action),
    homePageState: routingReducer(state.homePageState, action),
    uploadFilesState: awsUploadFilesReducer(state.uploadFilesState, action),
    cameraState: cameraReducer(state.cameraState, action),
    waypointsState: waypointsReducer(state.waypointsState, action),
    waypointsPassingState: waypointReducer(state.waypointsPassingState, action),
    flavor: flavorReducer(state.flavor, action),
    blueprint: blueprintReducer(state.blueprint, action),
    anytime: anytimeReducer(state.anytime, action),
    bonus: bonusReducer(state.bonus, action),
    h2h: h2hReducer(state.h2h, action),
  );
}
