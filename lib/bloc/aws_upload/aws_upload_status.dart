import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AwsUploadStatus extends Equatable {
  final String fileName;

  AwsUploadStatus(this.fileName);

  static AwsUploadStatus fromMap(Map<String, dynamic> map) {
    final String status = map["status"];
    switch (status) {
      case "complete":
        return CompleteAwsUpload(map["fileUrl"]);
      case "progress":
        return ProgressAwsUpload(map["progress"], map["fileUrl"]);
      case "error":
        return FailAwsUpload(map["message"], map["fileUrl"]);
    }
    throw AssertionError("unknown status $status");
  }
}

class CompleteAwsUpload extends AwsUploadStatus {
  CompleteAwsUpload(String fileName) : super(fileName);

  @override
  List<Object> get props => [];
}

class ProgressAwsUpload extends AwsUploadStatus {
  final double progress;

  ProgressAwsUpload(this.progress, String fileName) : super(fileName);

  @override
  List<Object> get props => [progress];
}

class FailAwsUpload extends AwsUploadStatus {
  final String error;

  FailAwsUpload(this.error, String fileName) : super(fileName);

  @override
  List<Object> get props => [error];
}
