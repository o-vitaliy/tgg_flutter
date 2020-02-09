import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class RadioWidget extends ValueWidget {
  final List<SubmissionChoice> choices;

  RadioWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, String error, this.choices)
      : super(onValueChange, onSubmit, initialValue, error);

  @override
  State createState() => _RadioState();
}

class _RadioState extends State<RadioWidget> {
  List<SubmissionChoice> get choices => widget.choices;

  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

  String get error => widget.error;

  String get initialValue => widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Widget>.of(choices.map((choice) {
      return RadioListTile<String>(
        title: Text(choice.text),
        key: ValueKey(choice.text),
        value: choice.text,
        groupValue: initialValue,
        onChanged: (value) {
          onValueChange(value);
        },
      );
    }))
          ..add(Text(error ?? "")));
  }
}
