import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class DialogAction {
  final WidgetBuilder builder;

  DialogAction(this.builder);
}
