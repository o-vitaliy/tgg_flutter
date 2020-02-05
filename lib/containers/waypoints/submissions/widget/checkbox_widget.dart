import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class CheckboxWidget extends ValueWidget {
  final List<SubmissionChoice> choices;

  CheckboxWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      List<String> initialValue, String error, this.choices)
      : super(onValueChange, onSubmit, initialValue ?? List<String>.of([]),
            error);

  @override
  State createState() => _ChoiceInputState();
}

class _ChoiceInputState extends State<CheckboxWidget> {
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
    }))
          ..add(Text(error ?? ""))
          ..add(RaisedButton(
            child: const Text("Go!"),
            onPressed: onSubmit,
          )));
  }
}
