import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class ChoiceWidget extends ValueWidget {
  final List<SubmissionChoice> choices;

  ChoiceWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, String error, this.choices)
      : super(onValueChange, onSubmit, initialValue, error);

  @override
  State createState() => _ChoiceInputState();
}

class _ChoiceInputState extends State<ChoiceWidget> {
  final controller = TextEditingController();

  List<SubmissionChoice> get choices => widget.choices;

  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

  String get error => widget.error;

  String get initialValue => widget.initialValue;

  @override
  void initState() {
    super.initState();
    controller.text = initialValue;
    controller.addListener(() {
      onValueChange(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: List<Widget>.of(choices.map((choice) {
      return RadioListTile<String>(
        title: Text(choice.value),
        value: choice.value,
        groupValue: initialValue,
        onChanged: (String value) {
          onValueChange(value);
        },
      );
    })));
  }
}
