import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

class TextWidget extends StatefulValueWidget {
  final String caption;

  TextWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.caption,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  State createState() => _TextInputState();
}

class _TextInputState extends State<TextWidget> {
  final controller = TextEditingController();

  OnValueChange get onValueChange => widget.onValueChange;

  String get caption => widget.caption ?? "Caption";

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
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: caption),
    );
  }
}
