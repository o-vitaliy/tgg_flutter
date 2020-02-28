import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/data/providers/prefs_provider.dart';
import 'package:tgg/data/providers/providers.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

class MockedApiProvider extends Mock implements ApiProvider {}

class MockedPrefsProvider extends Mock implements PrefsProvider {}

class MockedLocationProvider extends Mock implements LocationProvider {}

class MockedFirebaseMessaging extends Mock implements FirebaseMessaging {}

const goodPin = "good";
const badPin = "bad";
const playthroughs = "playthroughs";
final mockedLoginResponse =
    File("test/data/mocks/login.json").readAsStringSync();
final mockedTeam = File("test/data/mocks/team.json").readAsStringSync();
const mockedLoginErrorResponse = """Pin must be 3 or 6 characters""";
final mockedPlaythroughs =
    File("test/data/mocks/playthroughs.json").readAsStringSync();
final mockedFlavorDefault =
    File("test/data/mocks/flavorDefault.json").readAsStringSync();
final mockedFlavorGame =
    File("test/data/mocks/flavorGame.json").readAsStringSync();
final mockedActiveWaypoints =
    File("test/data/mocks/activewaypoints.json").readAsStringSync();

const mockCreateMedia =
    """{"media_bucket":"gogame-breadcrumb-display-media","upload_key":"2017-08-12/immaculate-conception-church-powell-11-07/camera-/art-pose-2017-08-12-11-23-38.png","media_key":"2017-08-12/immaculate-conception-church-powell-11-07/camera-/images-<size>/art-pose-2017-08-12-11-23-38.jpeg","upload_mime_type":"image/png","media_mime_type":"image/jpeg","media_timestamp":1502562059,"media_type":"image","media_filename":"photoCompressed5.png","media_size":4616904,"options":{"is_uploaded":true,"is_uploading":true,"in_gallery":true,"is_ready":true,"media_duration":4,"caption":"Donkey Kong"},"id":"5c743270cffcee7eef899092"}""";

final mockRouting = File("test/data/mocks/routing.json").readAsStringSync();
final mockRoutingAllEnabled =
    File("test/data/mocks/routingAllEnabled.json").readAsStringSync();
final mockedAnytime = File("test/data/mocks/anytime.json").readAsStringSync();

final mockedInvited = File("test/data/mocks/invited.json").readAsStringSync();

final mockedApiProvider = MockedApiProvider();
final mockedPrefs = MockedPrefsProvider();
final mockedLocationProvider = MockedLocationProvider();
final mockedFirebaseMessaging = MockedFirebaseMessaging();

void initLoginMock() {
  when(mockedApiProvider.login(goodPin))
      .thenAnswer((_) => Future.value(mockedLoginResponse));
  when(mockedApiProvider.login(badPin))
      .thenAnswer((_) => Future.error(mockedLoginErrorResponse));
  when(mockedApiProvider.playthroughs(playthroughs))
      .thenAnswer((_) => Future.value(mockedPlaythroughs));
  when(mockedApiProvider.activeWaypoints())
      .thenAnswer((_) => Future.value(mockedActiveWaypoints));
  when(mockedApiProvider.waypointTriggerAction(
    waypointId: anyNamed("waypointId"),
    values: anyNamed("values"),
  )).thenAnswer((_) => Future.value(mockedActiveWaypoints));
  when(mockedApiProvider.createMedia(values: anyNamed("values")))
      .thenAnswer((_) => Future.value(mockCreateMedia));
  when(mockedApiProvider.putMedia(
    id: anyNamed("id"),
    values: anyNamed("values"),
  )).thenAnswer((_) => Future.value(mockCreateMedia));

  when(mockedApiProvider.getRouting("mockRoutingAllEnabled"))
      .thenAnswer((_) => Future.value(mockRoutingAllEnabled));
  when(mockedApiProvider.getRouting("mockRouting"))
      .thenAnswer((_) => Future.value(mockRouting));

  when(mockedApiProvider.teamTriggerAction(
          teamId: anyNamed("teamId"), values: anyNamed("values")))
      .thenAnswer((_) => Future.value(mockedInvited));

  //flavors
  when(mockedApiProvider.getFlavor(any))
      .thenAnswer((_) => Future.value(mockedFlavorDefault));
  when(mockedApiProvider.getGameFlavor(any))
      .thenAnswer((_) => Future.value(mockedFlavorGame));

  final position = Position.fromMap({'latitude': 50.44, 'longitude': 30.39});
  when(mockedLocationProvider.getLocation())
      .thenAnswer((_) => Future.value(position));

  // anytime
  when(mockedApiProvider.availableMissions(any, ModeHelper.to(Mode.camera)))
      .thenAnswer((_) => Future.value(mockedAnytime));
  when(mockedApiProvider.availableMissions(any, ModeHelper.to(Mode.anytime)))
      .thenAnswer((_) => Future.value(mockedAnytime));

  //firebase
  when(mockedFirebaseMessaging.getToken())
      .thenAnswer((_) => Future.value("firebase_token"));

  //team
  when(mockedApiProvider.team(teamId: anyNamed("teamId")))
      .thenAnswer((_) => Future.value(mockedTeam));
}
