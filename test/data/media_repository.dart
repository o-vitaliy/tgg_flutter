import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/media_repository.dart';
import 'package:tgg/models/models.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import 'mocks.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  File temp;
  setUp(() async {
    initLoginMock();
    final directory = await Directory.systemTemp.createTemp();
    final path = '${directory.path}/temp.png';
    temp = new File(path);
    temp.createSync();
    await temp.writeAsString("hehehe");
  });
  tearDown(() async {
    await temp?.delete();
  });
  group("media_data_source", () {
    test("getKey", () async {
      final mediaDataSource = MediaRepo(apiProvider: mockedApiProvider);

      final Playthrough playthrough =
          Playthrough.fromJsonMap(json.decode(mockedPlaythroughs));
      final LoginResponse loginResponse =
          LoginResponse.fromJsonMap(json.decode(mockedLoginResponse));
      final List waypoint = json
          .decode(mockedActiveWaypoints)
          .map((w) => Waypoint.fromJsonMap(w))
          .toList();

      final key = mediaDataSource.getKey(
          temp.path, playthrough, loginResponse.team, waypoint.first);
      expect(key, isNotNull);
    });

    test("create id", () async {
      final mediaDataSource = MediaRepo(apiProvider: mockedApiProvider);

      final Playthrough playthrough =
          Playthrough.fromJsonMap(json.decode(mockedPlaythroughs));
      final LoginResponse loginResponse =
          LoginResponse.fromJsonMap(json.decode(mockedLoginResponse));
      final List waypoint = json
          .decode(mockedActiveWaypoints)
          .map((w) => Waypoint.fromJsonMap(w))
          .toList();

      final key = mediaDataSource.getKey(
          temp.path, playthrough, loginResponse.team, waypoint.first);

      final id = await mediaDataSource.createMedia(temp.path, key, "");
      expect(id, "5c743270cffcee7eef899092");
    });

    test("mark media as uploaded", () async {
      final mediaDataSource = MediaRepo(apiProvider: mockedApiProvider);

      final Playthrough playthrough =
          Playthrough.fromJsonMap(json.decode(mockedPlaythroughs));
      final LoginResponse loginResponse =
          LoginResponse.fromJsonMap(json.decode(mockedLoginResponse));
      final List waypoint = json
          .decode(mockedActiveWaypoints)
          .map((w) => Waypoint.fromJsonMap(w))
          .toList();

      final key = mediaDataSource.getKey(
          temp.path, playthrough, loginResponse.team, waypoint.first);

      final result =
          await mediaDataSource.syncFileUpload("id", temp.path, key, "");

      expect(result, true);
    });
  });
}
