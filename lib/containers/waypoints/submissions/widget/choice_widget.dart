import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class ChoiceWidget extends ValueWidget {
  final List<SubmissionChoice> choices;

  ChoiceWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      List<String> initialValue, String error, this.choices)
      : super(onValueChange, onSubmit, initialValue ?? List<String>.of([]),
            error);

  @override
  State createState() => _ChoiceInputState();
}

class _ChoiceInputState extends State<ChoiceWidget> {
  List<SubmissionChoice> get choices => widget.choices;

  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

  String get error => widget.error;

  List<String> get initialValue => widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Widget>.of(choices.map((choice) {
      return CheckboxListTile(
        key: ValueKey(choice.value),
        value: initialValue.contains(choice.value),
        title: Text(choice.value),
        onChanged: (selected) {
          if (selected)
            initialValue.add(choice.value);
          else
            initialValue.remove(choice.value);
          onValueChange(initialValue);
        },
      );
    }))
          ..add(Text(error ?? ""))
          ..add(RaisedButton(
            child: const Text("Go!"),
            onPressed: onSubmit,
          )));
  }
}
