import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:tgg/data/h2h_repo.dart';
import 'package:tgg/models/challenge_invite_result.dart';

import 'mocks.dart';

main() {
  final lat = 1.0;
  final lng = 2.0;
  final accuracy = 3.0;
  final position = Position.fromMap({
    'latitude': lat,
    'longitude': lng,
    'accuracy': accuracy,
  });

  setUp(() {
    initLoginMock();
    when(mockedLocationProvider.getLocation())
        .thenAnswer((_) => Future.value(position));
  });
  group("h2h", () {
    test("registerFcm", () async {
      final repo = H2HRepo(
        apiProvider: mockedApiProvider,
        firebaseMessaging: mockedFirebaseMessaging,
        locationProvider: mockedLocationProvider,
      );
      final response = await repo.registerFcm("teamId");
      expect(response, isNotNull);

      verify(mockedApiProvider.teamTriggerAction(
          values: argThat(predicate((params) {
            return params != null &&
                params["params"]["registration_token"] == "firebase_token";
          }), named: "values"),
          teamId: "teamId"));
    });

    test("invite", () async {
      final repo = H2HRepo(
        apiProvider: mockedApiProvider,
        firebaseMessaging: mockedFirebaseMessaging,
        locationProvider: mockedLocationProvider,
      );
      final ChallengeInviteResult response = await repo.invite("teamId", "pin");
      expect(response, isNotNull);
      expect(response.status.isOk, true);
      expect(response.status.result, "sent");

      verify(mockedApiProvider.teamTriggerAction(
          values: argThat(predicate((params) {
            expect(params, isNotNull);
            expect(params["name"], "challenge");
            expect(params["params"], isNotNull);
            expect(params["params"]["mode_name"], "head_to_head");
            expect(params["params"]["team_id"], "pin");
            expect(params["params"]["action"], "send");
            return true;
          }), named: "values"),
          teamId: "teamId"));
    });
    test("acceptInvite accepted", () async {
      final repo = H2HRepo(
        apiProvider: mockedApiProvider,
        firebaseMessaging: mockedFirebaseMessaging,
        locationProvider: mockedLocationProvider,
      );
      final response =
          await repo.acceptInvite("teamId", "oponnentTeamId", true);
      expect(response, isNotNull);

      verify(mockedApiProvider.teamTriggerAction(
          values: argThat(predicate((params) {
            expect(params, isNotNull);
            expect(params["name"], "challenge");
            expect(params["params"], isNotNull);
            expect(params["params"]["team_id"], "oponnentTeamId");
            expect(params["params"]["action"], "accept");
            return true;
          }), named: "values"),
          teamId: "teamId"));
    });
    test("acceptInvite decline", () async {
      final repo = H2HRepo(
        apiProvider: mockedApiProvider,
        firebaseMessaging: mockedFirebaseMessaging,
        locationProvider: mockedLocationProvider,
      );
      final response =
          await repo.acceptInvite("teamId", "oponnentTeamId", false);
      expect(response, isNotNull);

      verify(mockedApiProvider.teamTriggerAction(
          values: argThat(predicate((params) {
            expect(params, isNotNull);
            expect(params["name"], "challenge");
            expect(params["params"], isNotNull);
            expect(params["params"]["team_id"], "oponnentTeamId");
            expect(params["params"]["action"], "decline");
            return true;
          }), named: "values"),
          teamId: "teamId"));
    });
  });
}
