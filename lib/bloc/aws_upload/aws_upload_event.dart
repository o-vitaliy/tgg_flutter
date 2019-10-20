import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'aws_upload_status.dart';

@immutable
abstract class AwsUploadEvent extends Equatable {
  AwsUploadEvent([List props = const <dynamic>[]]) : super();
}

class StartAwsUploadEvent extends AwsUploadEvent {
  final String url;

  StartAwsUploadEvent(this.url);

  @override
  List<Object> get props => [url];
}

class ProgressChangedAwsUploadEvent extends AwsUploadEvent {
  final AwsUploadStatus status;

  ProgressChangedAwsUploadEvent(this.status);

  @override
  List<Object> get props => null;
}
