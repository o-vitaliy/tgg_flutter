import 'package:flutter/material.dart';

typedef OnValueChange = void Function(dynamic newValue);
typedef OnSubmit = void Function(BuildContext);
typedef OnHint = void Function();

abstract class ValueWidget {
  final OnValueChange onValueChange;
  final OnSubmit onSubmit;
  final initialValue;

  ValueWidget(this.onValueChange, this.onSubmit, this.initialValue);
}

abstract class StatelessValueWidget extends StatelessWidget {
  final OnValueChange onValueChange;
  final OnSubmit onSubmit;
  final initialValue;

  StatelessValueWidget(this.onValueChange, this.onSubmit, this.initialValue,
      {Key key})
      : super(key: key);
}

abstract class StatefulValueWidget extends StatefulWidget {
  final OnValueChange onValueChange;
  final OnSubmit onSubmit;
  final initialValue;

  StatefulValueWidget(this.onValueChange, this.onSubmit, this.initialValue,
      {Key key})
      : super(key: key);
}
