import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:moor/moor.dart' as m;
import 'package:tgg/common/routing/routing_state.dart';
import 'package:tgg/models/routing.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

import '../data/mocks.dart';

main() {
  group("RoutingState", () {
    test("find route", () {
      final routing = Routing.fromJsonMap(json.decode(mockRoutingAllEnabled));
      final RoutingState state = RoutingState.initial(routing.modes);
      expect(state.findMode(Mode.head_to_head).title, "H2H");
    });

    test("has all routes", () {
      final routing = Routing.fromJsonMap(json.decode(mockRoutingAllEnabled));
      final RoutingState state = RoutingState.initial(routing.modes)
          .copyWith(hasAnytimes: m.Value(true), hasBonus: m.Value(false));
      final modes = state.activeModes;
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.main),
              orElse: () => null),
          isNotNull);
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.head_to_head),
              orElse: () => null),
          isNotNull);
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.camera),
              orElse: () => null),
          isNotNull);
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.anytime),
              orElse: () => null),
          isNotNull);
    });

    test("has any time", () {
      final routing = Routing.fromJsonMap(json.decode(mockRoutingAllEnabled));
      final RoutingState state = RoutingState.initial(routing.modes)
          .copyWith(hasAnytimes: m.Value(true), hasBonus: m.Value(false));
      final modes = state.activeModes;
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.anytime),
              orElse: () => null),
          isNotNull);
    });
    test("has not any time", () {
      final routing = Routing.fromJsonMap(json.decode(mockRoutingAllEnabled));
      final RoutingState state = RoutingState.initial(routing.modes)
          .copyWith(hasAnytimes: m.Value(false), hasBonus: m.Value(false));
      final modes = state.activeModes;
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.anytime),
              orElse: () => null),
          isNull);
    });
    test("has bonus", () {
      final routing = Routing.fromJsonMap(json.decode(mockRoutingAllEnabled));
      final RoutingState state = RoutingState.initial(routing.modes)
          .copyWith(hasAnytimes: m.Value(true), hasBonus: m.Value(true));
      final modes = state.activeModes;
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.camera),
              orElse: () => null),
          isNotNull);
    });
    test("has not bonus", () {
      final routing = Routing.fromJsonMap(json.decode(mockRoutingAllEnabled));
      final RoutingState state = RoutingState.initial(routing.modes)
          .copyWith(hasAnytimes: m.Value(false), hasBonus: m.Value(false));
      final modes = state.activeModes;
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.camera),
              orElse: () => null),
          isNull);
    });

    test("any time is not eabled", () {
      final routing = Routing.fromJsonMap(json.decode(mockRouting));
      final RoutingState state = RoutingState.initial(routing.modes)
          .copyWith(hasAnytimes: m.Value(true), hasBonus: m.Value(true));
      final modes = state.activeModes;
      expect(
          modes.firstWhere((m) => m.name == ModeHelper.to(Mode.anytime),
              orElse: () => null),
          isNull);
    });
  });
}
