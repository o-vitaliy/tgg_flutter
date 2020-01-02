import 'package:redux/redux.dart';
import 'package:tgg/actions/upload_file_action.dart';
import 'package:tgg/redux_model/upload_files_state.dart';

final uploadFilesReducer = combineReducers<UploadFilesState>([
  new TypedReducer<UploadFilesState, ChangeFileUploadProgressAction>(
      _changeFileUploadProgress),
  new TypedReducer<UploadFilesState, AddFileToUploadAction>(
      _addFileToUploadAction),
]);

UploadFilesState _changeFileUploadProgress(UploadFilesState state, action) {
  final a = action as ChangeFileUploadProgressAction;
  return state.updateProgress(
    url: a.url,
    progress: a.progress,
  );
}

UploadFilesState _addFileToUploadAction(UploadFilesState state, action) {
  final a = action as AddFileToUploadAction;
  return state.updateProgress(
    url: a.url,
    progress: 0,
  );
}
