import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/widget/submissions_builder.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

import 'material_wrapper.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget buildComponent(SubmissionType type, Function(dynamic) onChange) {
    final t = type.toString().split(".")[1];
    return build(
        WaypointSubmissionItem.initial(0, WaypointSubmission.from(t).first),
        onChange,
        (_) {});
  }

  testWidgets('TextField is not empty if text was typed',
      (WidgetTester tester) async {
    String value;

    await tester.pumpWidget(
        MaterialWrapper((c) => buildComponent(SubmissionType.text, (newValue) {
              value = newValue;
            })));

    final testText = "testText";
    final Finder textFinder = find.byType(TextField);
    await tester.enterText(textFinder, testText);
    expect(value, testText);
  });

  /* testWidgets('TextField clicked button', (WidgetTester tester) async {
    bool clicked;

    await tester.pumpWidget(
        MaterialWrapper((c) => build(SubmissionType.text, null, (_) {}, () {
              clicked = true;
            })));

    final Finder button = find.byType(RaisedButton);
    await tester.tap(button);
    expect(clicked, true);
  });*/
}
