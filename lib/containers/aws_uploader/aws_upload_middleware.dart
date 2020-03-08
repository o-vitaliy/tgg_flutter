import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/data/providers/native_provider.dart';
import 'package:tgg/data/providers/remote_config.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'aws_upload_action.dart';
import 'aws_upload_status.dart';

StreamSubscription _subscription;

List<Middleware<AppState>> createUploadMiddleware() {
  return [
    new TypedMiddleware<AppState, AwsAddFileAction>(
        _createKeyMiddleware()),
    new TypedMiddleware<AppState, AwsStartFileUpload>(_runUploadMiddleware()),
  ];
}

Middleware<AppState> _createKeyMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is AwsAddFileAction) {
      final AppState state = store.state;
      final url = action.url;
      final String key = mediaRepo.getKey(action.url,
          state.playthrough.playthrough, state.team, action.waypoint);

      final Config config = new Config();
      final bucketId = await config.awsBucketId;

      final mediaId = await mediaRepo.createMedia(url, key, bucketId);
      await daoMedia.insert(mediaId, url, key);

      store.dispatch(AwsStartFileUpload(url, key));
    }
    next(action);
  };
}

Middleware<AppState> _runUploadMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is AwsStartFileUpload) {
      final url = action.url;
      final key = action.key;
      if (_subscription == null) {
        final s = await nativeProvider.getEventStream();

        _subscription = s
            .where((el) => el["type"] == "AwsUpload")
            .map<AwsUploadStatus>((dynamic element) =>
                AwsUploadStatus.fromMap(element.cast<String, dynamic>()))
            .listen((data) => processProgress(store, data));
      }

      final Config config = new Config();
      final accessKeyId = await config.awsAccessKey;
      final secretAccessKey = await config.awsSecretAccessKey;
      final bucketId = await config.awsBucketId;
      nativeProvider
          .upload(accessKeyId, secretAccessKey, bucketId, url, key)
          .then((_) {
        store.dispatch(AwsProgressChangedAction(url, 0));
      });
    }
    next(action);
  };
}

void _runOnComplete(String url) async {
  final Config config = new Config();
  final data = await daoMedia.findByUrl(url);
  await daoMedia.updateUploadedByUrl(url, true);
  final bucketId = await config.awsBucketId;
  await mediaRepo.syncFileUpload(data.mediaId, url, data.key, bucketId);
}

void processProgress(Store store, AwsUploadStatus status) {
  if (status is ProgressAwsUpload) {
    store.dispatch(
        AwsProgressChangedAction(status.fileName, status.progress));
  } else if (status is CompleteAwsUpload) {
    Fluttertoast.showToast(msg: "completed upload url ${status.fileName}");
    store.dispatch(AwsProgressChangedAction(status.fileName, 1));
    _runOnComplete(status.fileName);
  } else if (status is FailAwsUpload) {
    Fluttertoast.showToast(msg: "failed upload url ${status.fileName}");
    store.dispatch(AwsRemoveFileUploadAction(status.fileName));
  }

  if ((store.state as AppState).uploadFilesState.progress == 1) {
    _subscription?.cancel();
    _subscription = null;
  }
}
