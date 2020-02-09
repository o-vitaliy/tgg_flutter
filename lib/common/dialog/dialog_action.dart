import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class DialogAction {
  final BuildContext context;
  final WidgetBuilder builder;

  DialogAction(this.context, this.builder);
}
