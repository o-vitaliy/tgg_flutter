import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tgg/data/bonus_repo.dart';
import 'package:tgg/data/dao/dao_answer.dart';
import 'package:tgg/data/dao/dao_hints.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/dao/dao_points.dart';
import 'package:tgg/data/dao/dao_submission.dart';
import 'package:tgg/data/dao/dao_waypoints.dart';
import 'package:tgg/data/dao/db.dart';
import 'package:tgg/data/location_repo.dart';
import 'package:tgg/data/login_repo.dart';
import 'package:tgg/data/playthrought_repository.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/data/providers/providers.dart';
import 'package:tgg/data/routing_repository.dart';
import 'package:tgg/data/statics_repo.dart';
import 'package:tgg/data/team_repo.dart';
import 'package:tgg/data/waypoint_repository.dart';

import 'anytime_repo.dart';
import 'h2h_repo.dart';
import 'media_repository.dart';

final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
final FirebaseAnalytics _analytics = FirebaseAnalytics();

final ApiProvider apiProvider = ApiProvider();
final PrefsProvider prefsProvider = PrefsProvider();
final LocationProvider locationProvider = new LocationProvider();

final AppDatabase database = AppDatabase();
final DaoSubmission daoSubmission = DaoSubmission(database);
final DaoMedia daoMedia = DaoMedia(database);
final DaoHint daoHint = DaoHint(database);
final DaoAnswer daoAnswer = DaoAnswer(database);
final DaoWaypoint daoWaypoint = DaoWaypoint(database);
final DaoPoints daoPoints = DaoPoints(database);

// repos
final StaticRepo staticRepo = StaticRepo(apiProvider: apiProvider);
final LoginRepo loginRepo =
    LoginRepo(apiProvider: apiProvider, prefs: prefsProvider);
final PlaythroughRepo playthroughRepo =
    PlaythroughRepo(apiProvider: apiProvider);
final MediaRepo mediaRepo =
    MediaRepo(apiProvider: apiProvider, daoMedia: daoMedia);
final RoutingRepo routingRepo = RoutingRepo(apiProvider: apiProvider);

final WaypointsRepo waypointsRepo = WaypointsRepo(
  apiProvider: apiProvider,
  daoMedia: daoMedia,
  daoSubmission: daoSubmission,
  daoHint: daoHint,
  daoAnswer: daoAnswer,
  locationProvider: locationProvider,
  daoWaypoint: daoWaypoint,
);

final AnytimeRepo anytimeRepo = AnytimeRepo(
  apiProvider: apiProvider,
  waypointsRepo: waypointsRepo,
);

final BonusRepo bonusRepo = BonusRepo(
  apiProvider: apiProvider,
  waypointsRepo: waypointsRepo,
);

final LocationRepo locationRepo = LocationRepo(
  apiProvider: apiProvider,
  loginRepo: loginRepo,
  locationProvider: locationProvider,
);

final H2HRepo h2hRepo = H2HRepo(
  apiProvider: apiProvider,
  firebaseMessaging: firebaseMessaging,
  locationProvider: locationProvider,
);

final TeamRepo teamRepo = TeamRepo(
  apiProvider: apiProvider,
);
