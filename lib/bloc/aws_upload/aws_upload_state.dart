import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AwsUploadState extends Equatable {
  AwsUploadState([List props = const <dynamic>[]]) : super();
}

class InitialAwsUploadState extends AwsUploadState {
  @override
  List<Object> get props => [];
}

class UploadingAwsUploadState extends AwsUploadState {
  final int count;
  final int current;
  final double progress;

  UploadingAwsUploadState(this.count, this.current, this.progress);

  @override
  List<Object> get props => [count, current, progress];

  @override
  String toString() {
    return 'UploadingAwsUploadState{count: $count, current: $current, progress: $progress}';
  }
}
