import 'package:tgg/containers/camera/camera_reducer.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_reducer.dart';
import 'package:tgg/containers/waypoints/waypoints_reducer.dart';
import 'package:tgg/reducers/auth_reducer.dart';
import 'package:tgg/reducers/home_page_reducer.dart';
import 'package:tgg/reducers/login_reducer.dart';
import 'package:tgg/reducers/playthrough_reducer.dart';
import 'package:tgg/reducers/post_location_reducer.dart';
import 'package:tgg/reducers/theme_data_reducer.dart';
import 'package:tgg/reducers/upload_reducer.dart';
import 'package:tgg/redux_model/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: false,
    themeData: themeDataReducer(state.themeData, action),
    loginResponse: authReducer(state.loginResponse, action),
    playthrough: playthoughReducer(state.playthrough, action),
    postLocationTimer: postLocationReducer(state.postLocationTimer, action),
    loginState: loginReducer(state.loginState, action),
    homePageState: homePageReducer(state.homePageState, action),
    uploadFilesState: uploadFilesReducer(state.uploadFilesState, action),
    cameraState: cameraReducer(state.cameraState, action),
    waypointsState: waypointsReducer(state.waypointsState, action),
    waypointState: waypointReducer(state.waypointState, action),
  );
}
