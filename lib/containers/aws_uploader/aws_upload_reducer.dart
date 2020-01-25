import 'package:redux/redux.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';

import 'aws_upload_state.dart';

final awsUploadFilesReducer = combineReducers<AwsUploadState>([
  new TypedReducer<AwsUploadState, ChangeFileUploadProgressAction>(
      _changeFileUploadProgress),
  new TypedReducer<AwsUploadState, AddFileToUploadAction>(
      _addFileToUploadAction),
]);

AwsUploadState _changeFileUploadProgress(AwsUploadState state, action) {
  final a = action as ChangeFileUploadProgressAction;
  return state.updateProgress(
    url: a.url,
    progress: a.progress,
  );
}

AwsUploadState _addFileToUploadAction(AwsUploadState state, action) {
  final a = action as AddFileToUploadAction;
  return state.updateProgress(
    url: a.url,
    progress: 0,
  );
}
