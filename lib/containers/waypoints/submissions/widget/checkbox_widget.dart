import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class CheckboxWidget extends StatelessValueWidget {
  final List<SubmissionChoice> choices;

  CheckboxWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      List<String> initialValue, this.choices,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: List<Widget>.of(choices.map((choice) {
      return CheckboxListTile(
        key: ValueKey(choice.text),
        value: initialValue.contains(choice.text),
        title: Text(choice.text),
        onChanged: (selected) {
          if (selected)
            initialValue.add(choice.text);
          else
            initialValue.remove(choice.text);
          onValueChange(initialValue);
        },
      );
    })));
  }
}
