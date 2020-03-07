import 'package:tgg/models/waypoints/waypoint.dart';

class AwsAddFileAction {
  final String url;
  final Waypoint waypoint;

  AwsAddFileAction(this.url, this.waypoint);
}

class AwsStartFileUpload {
  final String url;
  final String key;

  AwsStartFileUpload(this.url, this.key);
}

class AwsProgressChangedAction {
  final String url;
  final double progress;

  AwsProgressChangedAction(this.url, this.progress);
}

class AwsRemoveFileUploadAction {
  final String url;

  AwsRemoveFileUploadAction(this.url);
}
