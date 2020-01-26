import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/dao/dao_submission.dart';
import 'package:tgg/data/dao/db.dart';
import 'package:tgg/data/location_repo.dart';
import 'package:tgg/data/login_repo.dart';
import 'package:tgg/data/playthrought_repository.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/data/providers/providers.dart';
import 'package:tgg/data/statics_repo.dart';
import 'package:tgg/data/waypoint_repository.dart';

import 'media_repository.dart';

ApiProvider apiProvider = ApiProvider();
StaticApiProvider staticApiProvider = StaticApiProvider();
PrefsProvider prefsProvider = PrefsProvider();
LocationProvider locationProvider = new LocationProvider();

AppDatabase database = AppDatabase();
DaoSubmission daoSubmission = DaoSubmission(database);
DaoMedia daoMedia = DaoMedia(database);

// repos
StaticRepo staticRepo = StaticRepo(apiProvider: staticApiProvider);
LoginRepo loginRepo = LoginRepo(apiProvider: apiProvider, prefs: prefsProvider);
PlaythroughRepo playthroughRepo =
    PlaythroughRepo(apiProvider: apiProvider, staticRepo: staticRepo);
MediaRepo mediaRepo = MediaRepo(apiProvider: apiProvider, daoMedia: daoMedia);

WaypointsRepo waypointsRepo = WaypointsRepo(
  apiProvider: apiProvider,
  daoMedia: daoMedia,
  daoSubmission: daoSubmission,
  locationProvider: locationProvider,
);
LocationRepo locationRepo = LocationRepo(
  apiProvider: apiProvider,
  loginRepo: loginRepo,
  locationProvider: locationProvider,
);
