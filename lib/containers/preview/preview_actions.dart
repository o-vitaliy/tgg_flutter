import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

@immutable
class InitPreviewAction {
  final ImagePreviewArguments args;

  InitPreviewAction(this.args);
}

@immutable
class RetakePreviewAction {
  final BuildContext context;

  RetakePreviewAction(this.context);
}

@immutable
class SubmitPreviewAction {
  final BuildContext context;

  SubmitPreviewAction(this.context);
}
