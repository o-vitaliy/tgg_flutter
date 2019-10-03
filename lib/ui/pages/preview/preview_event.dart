import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../pages.dart';

@immutable
abstract class PreviewEvent extends Equatable {
  PreviewEvent([List props = const <dynamic>[]]);
}

class InitializePreviewEvent extends PreviewEvent {
  final ImagePreviewArguments args;

  InitializePreviewEvent({@required this.args}) : super([args]);

  @override
  List<Object> get props => [args];
}
