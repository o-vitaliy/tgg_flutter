import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class RadioWidget extends StatelessValueWidget {
  final List<SubmissionChoice> choices;

  RadioWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.choices,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: List<Widget>.of(choices.map((choice) {
      return RadioListTile<String>(
        title: Text(choice.text),
        key: ValueKey(choice.text),
        value: choice.text,
        groupValue: initialValue,
        onChanged: (value) {
          onValueChange(value);
        },
      );
    })));
  }
}
