import 'package:tgg/data/bonus_repo.dart';
import 'package:tgg/data/dao/dao_answer.dart';
import 'package:tgg/data/dao/dao_hints.dart';
import 'package:tgg/data/dao/dao_media.dart';
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
import 'package:tgg/data/waypoint_repository.dart';

import 'anytime_repo.dart';
import 'media_repository.dart';

ApiProvider apiProvider = ApiProvider();
PrefsProvider prefsProvider = PrefsProvider();
LocationProvider locationProvider = new LocationProvider();

AppDatabase database = AppDatabase();
DaoSubmission daoSubmission = DaoSubmission(database);
DaoMedia daoMedia = DaoMedia(database);
DaoHint daoHint = DaoHint(database);
DaoAnswer daoAnswer = DaoAnswer(database);
DaoWaypoint daoWaypoint = DaoWaypoint(database);

// repos
StaticRepo staticRepo = StaticRepo(apiProvider: apiProvider);
LoginRepo loginRepo = LoginRepo(apiProvider: apiProvider, prefs: prefsProvider);
PlaythroughRepo playthroughRepo = PlaythroughRepo(apiProvider: apiProvider);
MediaRepo mediaRepo = MediaRepo(apiProvider: apiProvider, daoMedia: daoMedia);
RoutingRepo routingRepo = RoutingRepo(apiProvider: apiProvider);

WaypointsRepo waypointsRepo = WaypointsRepo(
  apiProvider: apiProvider,
  daoMedia: daoMedia,
  daoSubmission: daoSubmission,
  daoHint: daoHint,
  daoAnswer: daoAnswer,
  locationProvider: locationProvider,
  daoWaypoint: daoWaypoint,
);

AnytimeRepo anytimeRepo = AnytimeRepo(
  apiProvider: apiProvider,
  waypointsRepo: waypointsRepo,
);

BonusRepo bonusRepo = BonusRepo(
  apiProvider: apiProvider,
  waypointsRepo: waypointsRepo,
);

LocationRepo locationRepo = LocationRepo(
  apiProvider: apiProvider,
  loginRepo: loginRepo,
  locationProvider: locationProvider,
);
