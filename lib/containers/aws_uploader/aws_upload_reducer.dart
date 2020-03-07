import 'package:redux/redux.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';

import 'aws_upload_state.dart';

final awsUploadFilesReducer = combineReducers<AwsUploadState>([
  new TypedReducer<AwsUploadState, AwsProgressChangedAction>(
      _changeFileUploadProgress),
  new TypedReducer<AwsUploadState, AwsAddFileAction>(
      _addFileToUploadAction),
]);

AwsUploadState _changeFileUploadProgress(AwsUploadState state, action) {
  final a = action as AwsProgressChangedAction;
  return state.updateProgress(
    url: a.url,
    progress: a.progress,
  );
}

AwsUploadState _addFileToUploadAction(AwsUploadState state, action) {
  final a = action as AwsAddFileAction;
  return state.updateProgress(
    url: a.url,
    progress: 0,
  );
}
