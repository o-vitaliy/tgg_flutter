import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/messaging/messaging_delegator.dart';
import 'package:tgg/containers/h2h/h2h_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

final _params = json.encode(
    """{"team_id":"5e52a6c4d71f10001a48a104","mode_name":"head_to_head"}""");
final _paramsFinished = json.encode(
    """{"team_id":"5e52a6c4d71f10001a48a104","mode_name":"head_to_head","points":50,"successful":true,"agreed":true}""");

final _challengeReceivedJson = """
{"event": "challenge-received", "params": $_params }
""";

final _challengeAcceptedJson = """
{"event": "challenge-accepted", "params": $_params }
""";
final _challengeDeclinedJson = """
{"event": "challenge-declined", "params": $_params }
""";
final _challengeFinishedJson = """
{"event": "challenge-finished", "params": $_paramsFinished }
""";

class MockedStore<T> extends Mock implements Store<T> {}

main() {
  MessageDelegator delagator;
  Store<AppState> store;

  setUp(() {
    store = MockedStore();
    delagator = MessageDelegator(store);
  });
  group("ChallangeInvite", () {
    test("parse", () {
      delagator.delegate(json.decode(_challengeReceivedJson));

      verify(store.dispatch(argThat(predicate((params) {
        expect(params, isInstanceOf<H2HReceiveInviteAction>());
        return true;
      }))));
    });

    group("ChallangeAccepted", () {
      test("accpted", () {
        delagator.delegate(json.decode(_challengeAcceptedJson));
        verify(store.dispatch(argThat(predicate((params) {
          expect(params, isInstanceOf<H2HInviteAcceptedAction>());
          expect(params.accepted, true);
          return true;
        }))));
      });
      test("declined", () {
        delagator.delegate(json.decode(_challengeDeclinedJson));
        verify(store.dispatch(argThat(predicate((params) {
          expect(params, isInstanceOf<H2HInviteAcceptedAction>());
          expect(params.accepted, false);
          return true;
        }))));
      });
    });

    group("ChallangeFinished", () {
      test("finished", () {
        delagator.delegate(json.decode(_challengeFinishedJson));
        verify(store.dispatch(argThat(predicate((params) {
          expect(params, isInstanceOf<H2HResultAction>());
          expect(params.result.points, 50);
          expect(params.result.successful, true);
          expect(params.result.agreed, true);
          return true;
        }))));
      });
    });
  });
}
