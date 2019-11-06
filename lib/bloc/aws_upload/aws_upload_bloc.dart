import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tgg/data/providers/native_provider.dart';
import 'package:tgg/data/providers/remote_config.dart';

import 'aws_upload_status.dart';
import 'bloc.dart';

class AwsUploadBloc extends Bloc<AwsUploadEvent, AwsUploadState> {
  AwsUploadBloc(this.config, this.analytics) : assert(config != null);
  final Config config;
  final FirebaseAnalytics analytics;

  Future<String> _accessKeyId() => config.awsAccessKey;

  Future<String> _secretAccessKey() => config.awsSecretAccessKey;

  Future<String> _bucketId() => config.awsBucketId;

  final _upload = Map<String, double>();

  StreamSubscription _subscription;

  @override
  AwsUploadState get initialState => InitialAwsUploadState();

  @override
  Stream<AwsUploadState> mapEventToState(AwsUploadEvent event) async* {
    if (event is StartAwsUploadEvent) {

      if (_upload.length == 0) {
        listen();
      }
      _upload[event.url] = 0;

      final accessKeyId = await _accessKeyId();
      final secretAccessKey = await _secretAccessKey();
      final bucketId = await _bucketId();

      await nativeProvider.upload(
        accessKeyId,
        secretAccessKey,
        bucketId,
        event.url,
      );

      analytics.logEvent(name: "submited upload", parameters: {
        "accessKeyId": accessKeyId,
        "url": event.url,
      });
    } else if (event is ProgressChangedAwsUploadEvent) {
      final AwsUploadStatus status = event.status;
      if (status is ProgressAwsUpload) {
        _upload[status.fileName] = status.progress;
      } else if (status is CompleteAwsUpload) {
        Fluttertoast.showToast(msg: "completed upload url ${status.fileName}");
        _upload[status.fileName] = 1.0;
      } else if (status is FailAwsUpload) {
        Fluttertoast.showToast(msg: "failed upload url ${status.fileName}");
        _upload.remove(status.fileName);
        //dispatch(StartAwsUploadEvent(status.fileName));
      }

      final totalProgress = _upload.values.reduce((v1, v2) => v1 + v2);
      final total = _upload.length.toDouble();
      final current = _upload.values.takeWhile((v1) => v1 < 1).length;

      yield UploadingAwsUploadState(
          _upload.length, current, totalProgress / total);

      if (totalProgress == total) {
        _upload.clear();
        _subscription.cancel();
        _subscription = null;
        yield UploadingAwsUploadState(0, 0, 0);
      }
    }
  }

  void listen() async {
    final s = await nativeProvider.getEventStream();

    _subscription = s
        .where((el) => el["type"] == "AwsUpload")
        .map<AwsUploadStatus>((dynamic element) =>
            AwsUploadStatus.fromMap(element.cast<String, dynamic>()))
        .listen((data) => dispatch(ProgressChangedAwsUploadEvent(data)));
  }
}
