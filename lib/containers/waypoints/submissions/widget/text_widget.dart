import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

class TextWidget extends ValueWidget {
  TextWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, String error)
      : super(onValueChange, onSubmit, initialValue, error);

  @override
  State createState() => _TextInputState();
}

class _TextInputState extends State<TextWidget> {
  final controller = TextEditingController();

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
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
        ),
        error != null ? Text(error) : SizedBox.shrink(),
      ],
    );
  }
}
