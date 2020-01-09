import 'package:flutter/material.dart';

typedef OnValueChange = void Function(String newValue);
typedef OnSubmit = void Function();

abstract class ValueWidget extends StatefulWidget {
  final OnValueChange onValueChange;
  final OnSubmit onSubmit;
  final String initialValue;
  final String error;

  ValueWidget(this.onValueChange, this.onSubmit, this.initialValue, this.error);
}
