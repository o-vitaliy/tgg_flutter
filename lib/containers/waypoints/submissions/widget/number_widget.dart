import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

class NumberWidget extends ValueWidget {
  NumberWidget(
      OnValueChange onValueChange, OnSubmit onSubmit, String initialValue)
      : super(onValueChange, onSubmit, initialValue);

  @override
  State createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberWidget> {
  final controller = TextEditingController();

  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

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
    return Column(
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.number,
          controller: controller,
        ),
      ],
    );
  }
}
